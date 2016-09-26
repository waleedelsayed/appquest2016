import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var strengthLabel: UILabel!
    @IBOutlet weak var strengthIndicator: UIProgressView!
    let locationManager = CLLocationManager()
    
    @IBOutlet weak var startDetector: UIButton!
    @IBOutlet weak var stopDetector: UIButton!
    @IBOutlet weak var logSolution: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.headingFilter = kCLHeadingFilterNone
        locationManager.delegate = self
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
    
    @IBAction func startDetector(_ sender: UIButton) {
        locationManager.startUpdatingHeading()
        
        stopDetector.isEnabled = true
        stopDetector.setTitleColor(UIColor.blue, for: .normal)
        
        logSolution.isEnabled = true
        logSolution.setTitleColor(UIColor.blue, for: .normal)
        
        startDetector.isEnabled = false
        startDetector.setTitleColor(UIColor.lightGray, for: .disabled)
    }
    
    @IBAction func stopDetector(_ sender: UIButton) {
        locationManager.stopUpdatingHeading()
        strengthIndicator.progress = 0.0
        strengthLabel.text = String(strengthIndicator.progress)
        
        startDetector.isEnabled = true
        startDetector.setTitleColor(UIColor.blue, for: .normal)
        
        logSolution.isEnabled = false
        logSolution.setTitleColor(UIColor.lightGray, for: .disabled)
        
        stopDetector.isEnabled = false
        stopDetector.setTitleColor(UIColor.lightGray, for: .disabled)
        
    }
    
    @IBAction func logSolution(_ sender: UIButton) {
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
