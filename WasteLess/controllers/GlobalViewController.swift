
import UIKit
import CoreLocation

public class GlobalViewController: UIViewController {
  let TAB_HEIGHT: CGFloat = 40.0
  let mapViewController: MapViewController = MapViewController()
  let listViewController: ListViewController = ListViewController()
   var newPostController: NewPostTableViewController = NewPostTableViewController()
  
  lazy var segmentButton: UISegmentedControl = {
    let segment = UISegmentedControl()
    segment.insertSegmentWithTitle("Map", atIndex: 0, animated: false)
    segment.insertSegmentWithTitle("List", atIndex: 1, animated: false)
    segment.selectedSegmentIndex = 0
    return segment
  }()
  
  // MARK: - Static instance
  public class var globalController : GlobalViewController {
    struct Singleton {
      static let instance = GlobalViewController()
    }
    return Singleton.instance;
  }
  
  // MARK: - controller life cycle
  override public func viewDidLoad() {
    super.viewDidLoad()
    configureSubControllers()
    let titleView = UIView()
    titleView.frame = CGRectMake(0, 5, 20, 20)
    titleView.addSubview(segmentButton)
    segmentButton.frame = CGRectMake(0, 0, 100, 25)
    segmentButton.addTarget(self, action: "toggleControllers:", forControlEvents: UIControlEvents.AllEvents)
    self.navigationItem.titleView = segmentButton
    let plusButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "newPostTapped")
    self.navigationItem.rightBarButtonItem = plusButton
  }
  
  public override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    self.mapViewController.view.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
    self.listViewController.view.frame = CGRectMake(0.0, 0.0, self.view.bounds.width, self.view.bounds.height)
    self.newPostController.view.frame = CGRectMake(0.0, 0.0, self.view.bounds.width, self.view.bounds.height)
  }
  
  override public func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.view.bringSubviewToFront(listViewController.view)
    self.view.bringSubviewToFront(mapViewController.view)
  }
  
  // MARK: - Sub View/Controller management
  func configureSubControllers() {
    self.mapViewController.willMoveToParentViewController(self)
    self.view.addSubview(self.mapViewController.view)
    self.addChildViewController(self.mapViewController)
    self.mapViewController.didMoveToParentViewController(self)
    
    self.listViewController.willMoveToParentViewController(self)
    self.view.addSubview(self.listViewController.view)
    self.addChildViewController(self.listViewController)
    self.listViewController.didMoveToParentViewController(self)
    
    self.newPostController.willMoveToParentViewController(self)
    self.view.addSubview(self.newPostController.view)
    self.addChildViewController(self.newPostController)
    self.newPostController.didMoveToParentViewController(self)
    
  }
  
  //MARK: - Actions 
  func toggleControllers(segmentSender:UISegmentedControl)  {
    self.view.endEditing(true)
    if (segmentSender.selectedSegmentIndex == 0) {
      self.view.bringSubviewToFront(self.mapViewController.view)
    }else {
      self.view.bringSubviewToFront(self.listViewController.view)
    }
  }
  
  func newPostTapped() {
    self.view.bringSubviewToFront(self.newPostController.view)
  }
}
