
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
  let mainMap: MKMapView = {
    let map = MKMapView()
    return map
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(self.mainMap)
    mainMap.delegate = self
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.mainMap.frame = self.view.bounds
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func mapView(mapView: MKMapView!, regionWillChangeAnimated animated: Bool) {
  }
  
  func moveToSearchedLocation(searchedLocation:CLPlacemark){
    var radius:Double = (searchedLocation.region as! CLCircularRegion).radius / 1000 //Convert to km
    var span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: radius / 112.0, longitudeDelta: radius / 112.0)
    var regionCenter = CLLocationCoordinate2D(latitude: searchedLocation.location.coordinate.latitude, longitude: searchedLocation.location.coordinate.longitude)
    var region:MKCoordinateRegion = MKCoordinateRegion(center: regionCenter, span: span)
    mainMap.setRegion(region, animated: true)
  }
}
