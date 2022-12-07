import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MainAppDelegate {
    var window: UIWindow?

    var theme: Theme.Type {
        return DefaultTheme.self
    }

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupWindow()
        return true
    }

    private func setupWindow() {
        let viewController = ImageScreenAssembly().assemble()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
    }
}
