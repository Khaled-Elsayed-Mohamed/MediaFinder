import UIKit
import MapKit
import CoreLocation

protocol sendingDataDelegate {
    func sendData(data: String)
}

class MapKit: UIViewController {

    @IBOutlet weak var Map: MKMapView!
    
    @IBOutlet weak var addressLabel: UILabel!
    let locationManager = CLLocationManager()
    let regionMeters: Double = 1000000
    
    var delegate: sendingDataDelegate? = nil
    var previousLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationServices()
       
    }
    @IBAction func doneButton(_ sender: UIButton) {
        delegate?.sendData(data: addressLabel.text ?? "")
        dismiss(animated: true, completion: nil)
        
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAutherization()
        } else {
//            show alert letting the user know they have to turn this on
        }
    }
    
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
            Map.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAutherization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTrackingLocation()
// do ap stuff when we get premission
            break
        case .denied:
//            show alert instruction how to turn on premission
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
//            show an alert letting them know Sup
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    
    func startTrackingLocation() {
        Map.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: Map)
    }
    
    
    func getCenterLocation(for Map: MKMapView) -> CLLocation {
        let latitude = Map.centerCoordinate.latitude
        let longitude = Map.centerCoordinate.longitude
        
        return CLLocation(latitude: latitude, longitude: longitude)
    }

}


extension MapKit: CLLocationManagerDelegate {
    
    
// when user move and update his location
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionMeters, longitudinalMeters: regionMeters)
//        Map.setRegion(region, animated: true)
//    }

    
// if location got disable
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAutherization()
    }
}

extension MapKit: MKMapViewDelegate {
    func mapView(_ Map: MKMapView, regionDidChangeAnimated animated: Bool) {
        
        
        
        let center = getCenterLocation(for: Map)
        let geoCoder = CLGeocoder()
        
        guard let previousLocation = self.previousLocation else { return }
        
        guard center.distance(from: previousLocation) > 50 else { return }
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else {return}
    
            if let _ = error {
//                show alert
                return
            }
            
            guard let placemark = placemarks?.first else {
//                show alert
                return
            }
            
            let streetNumber = placemark.subThoroughfare ?? ""
            let mainAddress = "\(placemark.thoroughfare ?? "") \(placemark.locality ?? "")"
            
            DispatchQueue.main.async {
                self.addressLabel.text = "\(streetNumber) \(mainAddress)"
            }
        }
    }
}
