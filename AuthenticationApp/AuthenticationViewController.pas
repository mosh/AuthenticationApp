namespace AuthenticationApp;

interface

uses
  OAuth2Client,
  WebKit,
  UIKit;

type

  [IBObject]
  AuthenticationViewController = public class(UIViewController,IUIWebViewDelegate,IUIPopoverPresentationControllerDelegate)
  private
    method requestOAuth2Access;

  public

    method awakeFromNib; override;
    method viewDidLoad; override;
    method didReceiveMemoryWarning; override;

    [IBOutlet]property &delegate: weak IAuthenticationViewControllerDelegate;
    
    [IBOutlet]property authenticationWebView:weak UIWebView;
    
    method webViewDidFinishLoad(webView: UIWebView);
    
    
    method viewDidAppear(animated: BOOL); override;
    
    method adaptivePresentationStyleForPresentationController(controller: UIPresentationController): UIModalPresentationStyle;
    
  end;

  IAuthenticationViewControllerDelegate = public interface
    method performed(controller: AuthenticationViewController);
    method cancelled(controller: AuthenticationViewController);
  end;

implementation


method AuthenticationViewController.awakeFromNib;
begin
  inherited awakeFromNib;
  
  NSLog('awakeFromNib');
  preferredContentSize := CGSizeMake(700.0, 600.0);  
  
end;

method AuthenticationViewController.viewDidLoad;
begin
  inherited viewDidLoad;

  // Do any additional setup after loading the view.
  
  self.authenticationWebView.delegate := self;
  
  if(assigned(self.popoverPresentationController))then
  begin
    NSLog('assigning delegate');
    self.popoverPresentationController.delegate := self;
  end
  else
  begin
    NSLog('not assigning delegate');
  end;
  
  
end;

method AuthenticationViewController.didReceiveMemoryWarning;
begin
  inherited didReceiveMemoryWarning;

  // Dispose of any resources that can be recreated.
end;

method AuthenticationViewController.viewDidAppear(animated: BOOL);
begin
  requestOAuth2Access;
end;

method AuthenticationViewController.requestOAuth2Access;
begin
  var store := NXOAuth2AccountStore.sharedStore as NXOAuth2AccountStore;

  store.requestAccessToAccountWithType(OAuthConstants.kIDMOAuth2AccountType ) withPreparedAuthorizationURLHandler(method (preparedUrl:NSURL); begin

      self.authenticationWebView.loadRequest(NSURLRequest.requestWithURL(preparedUrl));
    end
     ); 

end;

method AuthenticationViewController.webViewDidFinishLoad(webView: UIWebView);
begin
  var url := webView.request.URL;
  
  var location := url.absoluteString().rangeOfString(OAuthConstants.kIDMOAuth2ApprovalPagePrefix) options(NSStringCompareOptions.NSCaseInsensitiveSearch).location;

  if(location <>  NSNotFound)then
  begin
    var accessResult := webView.stringByEvaluatingJavaScriptFromString('document.title');

    if(assigned(accessResult))then
    begin
      var success := accessResult.rangeOfString(OAuthConstants.kIDMOAuth2SuccessPagePrefix) options(NSStringCompareOptions.NSCaseInsensitiveSearch).location <>  NSNotFound;

      if(success)then
      begin
        try
          var arguments := accessResult;
          if(arguments.hasPrefix(OAuthConstants.kIDMOAuth2SuccessPagePrefix))then
          begin
            arguments := arguments.substringFromIndex(OAuthConstants.kIDMOAuth2SuccessPagePrefix.length+1);

            var redirectUrl := NSString.stringWithFormat('%@?%@',OAuthConstants.kIDMOAuth2RedirectURL, arguments);

            var store := NXOAuth2AccountStore.sharedStore as NXOAuth2AccountStore;

            store.handleRedirectURL(NSURL.URLWithString(redirectUrl));

          end
          else
          begin
            NSLog('No Prefix');
          end;
        except
          on E:Exception do
          begin
            NSLog('Failure in didFinishLoadForFrame');
            raise;
          end;
        end;
        self.delegate.performed(self);
      end
      else
      begin
          NSLog('Not Success');
          self.delegate.cancelled(self);
      end;
    end
    else
    begin
      NSLog('No AccessResult');
    end;

    NSLog('closed');
  end
  else
  begin
    NSLog('NotFound');
  end;
  
end;


method AuthenticationViewController.adaptivePresentationStyleForPresentationController(controller: UIPresentationController): UIModalPresentationStyle;
begin
  NSLog('adaptivePresentationStyleForPresentationController');
  //exit  UIKit.UIModalPresentationStyle.FullScreen; 
end;


end.
