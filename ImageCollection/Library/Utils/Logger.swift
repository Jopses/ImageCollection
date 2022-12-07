import Foundation

class Logger {
    static func log(_ message: String) {
        NSLog(message)
    }

    static func debugLog(_ message: String) {
        #if DEBUG
            NSLog(message)
        #endif
    }
}
