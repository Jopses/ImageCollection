import UIKit

public extension StyleWrapper where Element == UISwitch {

    /// Set onTint color for switch to secondaryVariant color from app theme palette
    static var primary: StyleWrapper {
        return .wrap { uiswitch, theme in
            uiswitch.tintColor = theme.colorPalette.primary
            uiswitch.onTintColor = theme.colorPalette.primary
        }
    }

    /// Set onTint color for switch to secondaryVariant color from app theme palette
    static var primaryVariant: StyleWrapper {
        return .wrap { uiswitch, theme in
            uiswitch.tintColor = theme.colorPalette.primaryVariant
            uiswitch.onTintColor = theme.colorPalette.primaryVariant
        }
    }

    /// Set onTint color for switch to secondaryVariant color from app theme palette
    static var secondary: StyleWrapper {
        return .wrap { uiswitch, theme in
            uiswitch.tintColor = theme.colorPalette.secondary
            uiswitch.onTintColor = theme.colorPalette.secondary
        }
    }

    /// Set onTint color for switch to secondaryVariant color from app theme palette
    static var secondaryVariant: StyleWrapper {
        return .wrap { uiswitch, theme in
            uiswitch.tintColor = theme.colorPalette.secondaryVariant
            uiswitch.onTintColor = theme.colorPalette.secondaryVariant
        }
    }
}
