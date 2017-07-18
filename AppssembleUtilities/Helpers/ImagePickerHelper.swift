//
//  ImagePickerHelper.swift
//  AppssembleUtilities
//
//  Created by Dobrean Dragos on 18/07/2017.
//  Copyright © 2017 appssemble. All rights reserved.
//

import Foundation
import AVFoundation
import Photos

enum ImagePickerType {
    case camera
    case library
}

public protocol ImagePickerProtocol: class {
    func didPickImage(helper: ImagePickerHelper, image: UIImage)
}

public class ImagePickerHelper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public weak var delegate: ImagePickerProtocol?
    weak var viewController: UIViewController?
    
    public struct Constants {
        // Initial popup
        static var locationTitle = "Location"
        static var locationMesage = "From where do you wish to upload the picture?"
        
        // Image source
        static var camera = "Camera"
        static var library = "Photo Library"
        
        // General
        static var cancel = "Cancel"
        static var error = "Error"
        
        // Require access
        static var cameraAccessRequired = "Camera access required for capturing photos!"
        static var cameraAccessAllow = "Allow Camera"
        
        static var photosLibraryAccessRequired = "Photo library access required!"
        static var photosLibraryAllow = "Allow Photo library"
        
        // Others
        static var targetWidth: CGFloat = 1024.0
    }
    
    public init(viewController: UIViewController) {
        self.viewController = viewController
        
    }
    
    // MARK: Public methods
    
    public func pickImage() {
        let alertController = UIAlertController(title: Constants.locationTitle, message: Constants.locationMesage, preferredStyle: .alert)
        
        let camera = UIAlertAction(title: Constants.camera, style: .default) { (_) in
            self.pickImage(sourceType: .camera)
        }
        
        let library = UIAlertAction(title: Constants.library, style: .default) { (_) in
            self.pickImage(sourceType: .library)
        }
        
        let cancel = UIAlertAction(title: Constants.cancel, style: .cancel)
        
        alertController.addAction(camera)
        alertController.addAction(library)
        alertController.addAction(cancel)
        
        viewController?.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Image picker delegate
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }
        
        if let resizedImage = resizeImage(image: image) {
            delegate?.didPickImage(helper: self, image: resizedImage)
        } else {
            delegate?.didPickImage(helper: self, image: image)
        }
    }
    
    // MARK: Private methods
    
    private func pickImage(sourceType: ImagePickerType) {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        switch sourceType {
        case .camera:
            if cameraAvailable(success: {
                self.pickImage(sourceType: .camera)
            }) {
                picker.sourceType = .camera
            } else {
                return
            }
        case .library:
            if libraryAvailable() {
                picker.sourceType = .photoLibrary
            } else {
                return
            }
        }
        
        picker.navigationBar.isTranslucent = false;
        picker.navigationBar.barStyle = .default;
        picker.navigationBar.tintColor = UIColor.white
        
        viewController?.present(picker, animated: true) {
            picker.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    func cameraAvailable(success: @escaping () -> Void) -> Bool {
        let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch authStatus {
        case .authorized:
            return true
        case .denied:
            permissionDeniedCamera()
        case .notDetermined:
            requestAccessCamera() {
                success()
            }
        default:
            requestAccessCamera() {
                success()
            }
        }
        
        return false
    }
    
    private func libraryAvailable() -> Bool {
        let status = PHPhotoLibrary.authorizationStatus()
        
        switch status {
        case .authorized:
            return true
        case .denied:
            permissionDeniedLibrary()
        case .notDetermined:
            requestPhotoLibraryAccess()
        default:
            requestPhotoLibraryAccess()
        }
        
        return false
    }
    
    private func permissionDeniedCamera() {
        let alert = UIAlertController(title: Constants.error,
                                      message: Constants.cameraAccessRequired,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: Constants.cancel, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: Constants.cameraAccessAllow, style: .cancel, handler: { (alert) -> Void in
            self.openSettingsMenu()
        }))
        
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    private func permissionDeniedLibrary() {
        let alert = UIAlertController(title: Constants.error,
                                      message: Constants.photosLibraryAccessRequired,
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: Constants.cancel, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: Constants.photosLibraryAllow, style: .cancel, handler: { (alert) -> Void in
            self.openSettingsMenu()
        }))
        
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    private func requestAccessCamera(success : @escaping () -> Void) {
        if #available(iOS 10.0, *) {
            requestCameraAccessiOS10(success)
        } else {
            requestCameraAccessPreiOS10(success)
        }
    }
    
    private func requestCameraAccessiOS10(_ success : @escaping () -> Void) {
        if #available(iOS 10.0, *) {
            AVCaptureDevice.defaultDevice(withDeviceType: .builtInWideAngleCamera, mediaType: AVMediaTypeVideo, position: .front)
            
            if let session = AVCaptureDeviceDiscoverySession.init(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaTypeVideo, position: .back) {
                
                if session.devices.count > 0 {
                    AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (granted: Bool) in
                        
                        if granted {
                            DispatchQueue.main.async {
                                success()
                            }
                        }
                    }
                }
            }
        }
    }
    
    private func requestCameraAccessPreiOS10(_ success : @escaping () -> Void) {
        if AVCaptureDevice.devices(withMediaType: AVMediaTypeVideo).count > 0 {
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo) { (granted: Bool) in
                if granted {
                    DispatchQueue.main.async {
                        success()
                    }
                }
            }
        }
        
    }
    
    private func requestPhotoLibraryAccess() {
        PHPhotoLibrary.requestAuthorization { (status: PHAuthorizationStatus) in
            if status == .authorized {
                DispatchQueue.main.async {
                    self.pickImage(sourceType: .library)
                }
            }
        }
    }
    
    private func resizeImage(image: UIImage) -> UIImage? {
        let scaleFactor = Constants.targetWidth / image.size.width
        let height = image.size.height * scaleFactor
        
        let newSize = CGSize(width: Constants.targetWidth, height: height)
        UIGraphicsBeginImageContext(newSize);
        
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height), blendMode: .normal, alpha: 1.0)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        if let image = newImage {
            return image
        }
        
        return nil
    }
    
    private func openSettingsMenu() {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(URL(string: UIApplicationOpenSettingsURLString)!)
        }
    }
}
