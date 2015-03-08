namespace AuthenticationApp;

interface

uses
  Sugar,
  UIKit;

type
  [IBObject]
  MainViewController = public class(UIViewController, IUIPopoverControllerDelegate, IAuthenticationViewControllerDelegate,IAuthInterestedParty)
  private
    {$REGION IUIPopoverControllerDelegate}
    method popoverControllerShouldDismissPopover(aPopoverController: UIPopoverController): Boolean;
    method popoverControllerDidDismissPopover(aPopoverController: UIPopoverController);
    {$ENDREGION}
    {$REGION IAuthenticationViewControllerDelegate}
    method performed(controller: AuthenticationViewController);
    method cancelled(controller: AuthenticationViewController);
    {$ENDREGION}
    
    method newSession(accessToken:String);
    method noSession;


  public
    method viewDidLoad; override;
    method didReceiveMemoryWarning; override;
    method prepareForSegue(aSegue: UIStoryboardSegue) sender(aSender: id); override;

    [IBAction] method togglePopover(aSender: id);
    [IBOutlet] property authenticationPopoverController: UIPopoverController;
  end;

implementation

method MainViewController.viewDidLoad;
begin
  inherited viewDidLoad;

  // Do any additional setup after loading the view.
  ApplicationAuthHelper.RegisterObservers(self);
end;

method MainViewController.didReceiveMemoryWarning;
begin
  inherited didReceiveMemoryWarning;

  // Dispose of any resources that can be recreated.
end;

{$REGION IUIPopoverControllerDelegate}
method MainViewController.popoverControllerShouldDismissPopover(aPopoverController: UIPopoverController):Boolean;
begin
end;

method MainViewController.popoverControllerDidDismissPopover(aPopoverController: UIPopoverController);
begin
  //authenticationPopoverController := nil;
end;
{$ENDREGION}

{$REGION IAuthentcationViewControllerDelegate}
method MainViewController.performed(controller: AuthenticationViewController);
begin
  //if UIDevice.currentDevice.userInterfaceIdiom = UIUserInterfaceIdiom.UIUserInterfaceIdiomPhone then 
  //begin
    dismissViewControllerAnimated(true) completion(nil);
  //end
  //else 
  //begin
  //  authenticationPopoverController.dismissPopoverAnimated(true);
  //  authenticationPopoverController := nil;
  //end;
end;

method MainViewController.cancelled(controller: AuthenticationViewController);
begin
end;

{$ENDREGION}

method MainViewController.prepareForSegue(aSegue: UIStoryboardSegue) sender(aSender: id);
begin
  if aSegue.identifier.isEqualToString('showAlternate') then 
  begin

    aSegue.destinationViewController.delegate := self;
    
    //var pp := aSegue.destinationViewController.popoverPresentationController;  
    
    //if(assigned(pp))then
    //begin
    //end;  
    
    //if UIDevice.currentDevice.userInterfaceIdiom = UIUserInterfaceIdiom.UIUserInterfaceIdiomPad then 
    //begin
    //  authenticationPopoverController := (aSegue as UIStoryboardPopoverSegue).popoverController;
    //  authenticationPopoverController.delegate := self;
    //end;
  end;
end;

method MainViewController.togglePopover(aSender: id);
begin
  if assigned(authenticationPopoverController) then 
  begin
    authenticationPopoverController.dismissPopoverAnimated(true);
    authenticationPopoverController := nil;
  end
  else 
  begin
    performSegueWithIdentifier('showAlternate') sender(aSender);
  end;
end;

method MainViewController.newSession(accessToken: String);
begin
  NSLog('newSession');
end;

method MainViewController.noSession;
begin
  NSLog('noSession');
end;


end.
