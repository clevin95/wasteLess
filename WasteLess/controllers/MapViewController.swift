
import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
  let locationManager:CLLocationManager = CLLocationManager()
  let mainMap: MKMapView = {
    let map = MKMapView()
    map.showsUserLocation = true
    return map
  }()
  var currentLocation:CLLocationCoordinate2D?
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.addSubview(self.mainMap)
    mainMap.delegate = self
    mainMap.showsUserLocation = true
    setUpLocationManager()
    NSNotificationCenter.defaultCenter().addObserver(self, selector: "addedPost", name: "addedPost", object: nil)
  }
  
  func setUpLocationManager() {
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.delegate = self
    locationManager.startUpdatingLocation()
  }
  
  
  override func viewDidAppear(animated: Bool) {
    self.mainMap.showsUserLocation = true
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.mainMap.frame = self.view.bounds
    PostManager.getPosts { (postsArray) -> Void in
      PostManager.sharedInstance.allPosts = postsArray
    }
  }
  
  func addedPost() {
    for post:Posting in PostManager.sharedInstance.allPosts {
      let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: post.latitude!, longitude: post.longitude!)
      let newAnnoation:PostingAnnotation = PostingAnnotation(coordinate: coordinate, title: post.name!, subtitle: post.productDescription!)
      self.mainMap.addAnnotation(newAnnoation)
      let region = MKCoordinateRegionMakeWithDistance(coordinate, 200, 200);
      self.mainMap.setRegion(self.mainMap.regionThatFits(region), animated:true)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func mapView(mapView: MKMapView!, regionWillChangeAnimated animated: Bool) {
  }
  
//  func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
//    let annotationView = MKAnnotationView()
//    return annotationView
//  }
  
  func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    
    let updatedLocation:CLLocation = locations[0] as! CLLocation
    currentLocation = updatedLocation.coordinate
  }
  
  func moveToSearchedLocation(searchedLocation:CLPlacemark){
    var radius:Double = (searchedLocation.region as! CLCircularRegion).radius / 1000 //Convert to km
    var span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: radius / 112.0, longitudeDelta: radius / 112.0)
    var regionCenter = CLLocationCoordinate2D(latitude: searchedLocation.location.coordinate.latitude, longitude: searchedLocation.location.coordinate.longitude)
    var region:MKCoordinateRegion = MKCoordinateRegion(center: regionCenter, span: span)
    mainMap.setRegion(region, animated: true)
  }
}
