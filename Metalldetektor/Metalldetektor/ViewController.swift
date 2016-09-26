import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var strengthIndicator: UIProgressView!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.headingFilter = kCLHeadingFilterNone
        locationManager.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        locationManager.startUpdatingHeading()
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(_:)), name: .UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillResignActive(_:)), name: .UIApplicationWillResignActive, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingHeading()
        NotificationCenter.default.removeObserver(self, name: .UIApplicationDidBecomeActive, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIApplicationWillResignActive, object: nil)
    }
    
    func applicationDidBecomeActive(_ notification: Notification) {
        locationManager.startUpdatingHeading()
    }
    
    func applicationWillResignActive(_ notification: Notification) {
        locationManager.stopUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let x = newHeading.x
        let y = newHeading.y
        let z = newHeading.z
        
        // Compute and display the magnitude (size or strength) of the vector: magnitude = sqrt(x*x + y*y + z*z)
        let maxMagnitude = 4000.0
        let magnitude = sqrt(x*x + y*y + z*z)
        let magnitudeRatio = magnitude / maxMagnitude
        strengthLabel.text = String(format: "%.1f", magnitude)
        strengthIndicator.progress = Float(magnitudeRatio)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        let errorCode = (error as NSError).code
        if errorCode == CLError.denied.rawValue {
            // This error indicates that the user has denied the application's request to use location services.
            manager.stopUpdatingHeading()
        } else if errorCode == CLError.headingFailure.rawValue {
            // This error indicates that the heading could not be determined, most likely because of strong magnetic interference.
            print("error heading failure")
        }
    }
    
    @IBAction func logSolution(_ sender: AnyObject) {
        var json = [String: Any]()
        json["task"] = "Metalldetektor"
        
        let solutionLogger = SolutionLogger(viewController: self)
        solutionLogger.scanQRCode { code in
            json["solution"] = code
            let solutionStr = SolutionLogger.JSONStringify(json)
            solutionLogger.logSolution(solutionStr)
        }
    }
}
