# appssembleUtilities
Utilities for a new project used by our team, for now in the first version it involves various extensions and a helper for image picking



# Installation
You can use this library using cocoapods, simply add "pod ‘AppssembleUtilities’" to your Podfile file and you are good to go



# Usage




# ImagePickerHelper 
Takes the burden of implementing all the validation needed in order for you to add the ability to pick an image 
from the library or camera, the strings as well as image radio can be edited via the ImagePickerHelper -> Constants struct.

Displays a popup that ask the user to chose an image either from library or take one with the camera 
and allows the user to select or take the picture, after that, you will recieve a callback with the chosen picture.

Usage:

        let picker = ImagePickerHelper(viewController: self)
        picker.delegate = self
        picker.pickImage()
        
        // MARK: ImagePickerProtocol
        
        func didPickImage(helper: ImagePickerHelper, image: UIImage) {
                // TODO: Do whatever with the image
        }

# Date

- dateString() -> Returns a string with the date in the "MM/dd/yyyy" format
- longDateString() -> Returns a string with the date in the "MM/dd/yyyy, hh:mm a" format
- dateFromString(string) -> Creates a date from the provided string

# NSDecimalNumber

- clean - Pretty formated amount string
- multiplyWithInt(int)
- divideWithInt(int)
- discountedWithInt(int) - Applies a discount

# NSLayoutConstraint

As there are no size classes for iPhone 4 and iPhone 5 we sometimes want custom constraint values for those, this
extension adds two fields in the attribute inspector panel on the storyboard/xib in which you can set the desired 
value for that specific constraint on iPhone 4 or 5

- iphone4Constraint
- iphone5Constraint

# String

- isNumeric
- isEmptyOrWhitespaces

# UIDevice

- screenType - Returns the screen type for the current device

# UILabel

Storyboard/XIB custom values for font size on iPhone 4 and 5  

- iphone4FontSize
- iphone5FontSize

# UIView

- clipToSuperview() - adds constraints to the current view in order to clip it to its superview
- addUnderline(height, color) - adds an underline as a border under the current view
- rotate(amount) - rotates the view with the specified amount


# LICENSE

WTFPL -> https://en.wikipedia.org/wiki/WTFPL
