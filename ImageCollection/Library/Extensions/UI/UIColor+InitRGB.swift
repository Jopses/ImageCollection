import UIKit

extension UIColor {
    @objc
    public convenience init(rgb: UInt32) {
        self.init(rgb: rgb, alpha: 1.0)
    }

    public convenience init(rgb: UInt32, alpha: CGFloat) {
        assert(rgb <= 0xffffff)
        let red = UInt8((rgb & 0xFF0000) >> 16)
        let green = UInt8((rgb & 0x00FF00) >> 8)
        let blue = UInt8(rgb & 0x0000FF)
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }

    @objc
    public convenience init(rgba: UInt32) {
        let red = UInt8((rgba & 0xFF000000) >> 24)
        let green = UInt8((rgba & 0x00FF0000) >> 16)
        let blue = UInt8((rgba & 0x0000FF00) >> 8)
        let alpha = UInt8(rgba & 0x000000FF)
        self.init(red: CGFloat(red) / 255,
                  green: CGFloat(green) / 255,
                  blue: CGFloat(blue) / 255,
                  alpha: CGFloat(alpha) / 255
        )
    }

    public convenience init(bgr: UInt) {
        self.init(bgr: bgr, alpha: 1.0)
    }

    public convenience init(bgr: UInt, alpha: CGFloat) {
        assert(bgr <= 0xffffff)
        let blue = UInt8((bgr & 0xFF0000) >> 16)
        let green = UInt8((bgr & 0x00FF00) >> 8)
        let red = UInt8(bgr & 0x0000FF)
        self.init(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: alpha)
    }

    fileprivate var rgba: [UInt8] {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        var white: CGFloat = 0

        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return [UInt8(red * 255),
                    UInt8(green * 255),
                    UInt8(blue * 255),
                    UInt8(alpha * 255)
            ]
        } else if getWhite(&white, alpha: &alpha) {
            return [UInt8(white * 255),
                    UInt8(white * 255),
                    UInt8(white * 255),
                    UInt8(alpha * 255)
            ]
        } else {
            return [0, 0, 0, 0] // HSL -> RGB too hard ;)
        }
    }
}

public func == (lhs: UIColor, rhs: UIColor) -> Bool {
    return lhs.rgba == rhs.rgba
}
