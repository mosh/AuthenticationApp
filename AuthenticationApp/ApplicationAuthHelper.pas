namespace AuthenticationApp;

interface

uses
  OAuth2Client,
  Foundation,Sugar;
  
type

  IAuthInterestedParty = public interface
    method newSession(accessToken:String);
    method noSession;
  end;


  ApplicationAuthHelper = public static class
  private
  protected
  public
    method Setup;
    method CurrentToken:String;
    method RegisterObservers(party:IAuthInterestedParty);
  end;


implementation

method ApplicationAuthHelper.RegisterObservers(party:IAuthInterestedParty);
begin
  var defaultCenter := NSNotificationCenter.defaultCenter;

  var store := NXOAuth2AccountStore.sharedStore as NXOAuth2AccountStore;

  defaultCenter.addObserverForName(NXOAuth2AccountStoreAccountsDidChangeNotification ) 
                object(store ) 
                queue(nil) 
                usingBlock(method(something:id); begin

                              var aNotification := something as NSNotification;  

                              if(assigned(aNotification.userInfo))then
                              begin

                                var accounts := store.accountsWithAccountType(OAuthConstants.kIDMOAuth2AccountType);

                                if(accounts.count > 0) then
                                begin

                                  party.noSession;

                                  party.newSession(accounts[0].accessToken.accessToken);

                                end;

                                NSLog('Success!! We have an access token.');

                              end
                              else
                              begin
                                party.noSession;
                                
                                NSLog('account removed, we lost access');
                              end;

                             end ); 

  defaultCenter.addObserverForName(NXOAuth2AccountStoreDidFailToRequestAccessNotification ) 
                object(store ) 
                queue(nil) 
                usingBlock(method(something:id); begin 

                             var aNotification := something as NSNotification;  

                             var error:NSError := aNotification.userInfo.objectForKey(NXOAuth2AccountStoreErrorKey);
                             NSLog('Error !! %@', error.localizedDescription);
                             party.noSession;

                             end ); 
end;

method ApplicationAuthHelper.Setup;
begin
  var path := NSBundle.mainBundle.pathForResource('Authentication') ofType('plist');
  var dictionaryOfValues := NSMutableDictionary.dictionaryWithContentsOfFile(path);
  if(assigned(dictionaryOfValues))then
  begin
    OAuthConstants.kIDMOAuth2ClientId := dictionaryOfValues['kIDMOAuth2ClientId'];
    OAuthConstants.kIDMOAuth2ClientSecret := dictionaryOfValues['kIDMOAuth2ClientSecret'];

    if(String.IsNullOrEmpty(OAuthConstants.kIDMOAuth2ClientId) or String.IsNullOrEmpty(OAuthConstants.kIDMOAuth2ClientSecret))then
    begin
      raise new NSException withName('NSException') reason('kIDMOAuth2ClientId or kIDMOAuth2ClientSecret are NullOrEmpty') userInfo(nil);
    end
    else
    begin
      NSLog('kIDMOAuth2ClientId %@', OAuthConstants.kIDMOAuth2ClientId);
      NSLog('kIDMOAuth2ClientSecret %@', OAuthConstants.kIDMOAuth2ClientSecret);
    end;

  end
  else
  begin
    NSLog('Path for resource %@',path);
    raise new NSException withName('NSException') reason('Failed to load Authentication.plist') userInfo(nil);
  end;

  var scopeSet := new NSMutableSet;
  scopeSet.addObject(OAuthConstants.kIDMOAuth2ProfileScope);
  scopeSet.addObject(OAuthConstants.kIDMOAuth2EmailScope);
  
  var store := NXOAuth2AccountStore.sharedStore as NXOAuth2AccountStore;

  store.setClientID(OAuthConstants.kIDMOAuth2ClientId) secret(OAuthConstants.kIDMOAuth2ClientSecret) scope(scopeSet) authorizationURL(NSURL.URLWithString(OAuthConstants.kIDMOAuth2AuthorizationURL)) tokenURL(NSURL.URLWithString(OAuthConstants.kIDMOAuth2TokenURL)) redirectURL(NSURL.URLWithString(OAuthConstants.kIDMOAuth2RedirectURL)) keyChainGroup('SailingLog') forAccountType(OAuthConstants.kIDMOAuth2AccountType);

end;

method ApplicationAuthHelper.CurrentToken:String;
begin
  var store := NXOAuth2AccountStore.sharedStore as NXOAuth2AccountStore;
  var existingAccounts := store.accountsWithAccountType(OAuthConstants.kIDMOAuth2AccountType);

  if(existingAccounts.count > 0)then
  begin
    NSLog('%@',existingAccounts[0].accessToken.accessToken);
    exit existingAccounts[0].accessToken.accessToken;
  end;
  exit '';
end;


end.
