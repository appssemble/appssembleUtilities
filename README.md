# appssembleUtilities
Utilities for a new project used by our team, for now in the first version it involves various extensions and a helper for image picking

# installation
You can use this library using cocoapods, simply add "pod ‘AppssembleUtilities’" to your Podfile file and you are good to go

# usage

ImagePickerHelper -> takes the burden of implementing all the validation needed in order for you to add the ability to pick an image from the library or camera, the messages can be edited via the ImagePickerHelper -> Constants struct

Usage:

        let picker = ImagePickerHelper(viewController: self)
        picker.delegate = self
