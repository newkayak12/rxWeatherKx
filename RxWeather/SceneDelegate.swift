import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        let sceneCoordinator = SceneCoordinator(window: window!)
        let weatherApi = OpenWeatherMapApi()
//        let locationProvider = StaticLocationProvider()
        let locationProvider = CoreLocationProvider()
        
        let viewModel = MainViewModel(title: "", sceneCoordinator: sceneCoordinator, weatherApi: weatherApi, locationProvider: locationProvider)
        let scene = Scene.main(viewModel)
        
        sceneCoordinator.transition(to: scene, using: .root, animated: false)
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

