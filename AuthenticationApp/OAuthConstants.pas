namespace AuthenticationApp;

interface

uses
  Foundation;
  
type

  OAuthConstants = public class
  public
    {the following items were obtained when registering this app in the Google APIs Console}
    {these are all specific to the client application - e.g. this iOS app}
    class kIDMOAuth2ClientId : NSString;
    class kIDMOAuth2ClientSecret : NSString;

  public
  const
    {should be in the format of urn:xxx:yyy:zzz, not http://localhost}
    kIDMOAuth2RedirectURL:NSString = 'urn:ietf:wg:oauth:2.0:oob';

    {these items were obtained from the Google API documentation}
    {https://developers.google.com/accounts/docs/OAuth2InstalledApp#overview}
    kIDMOAuth2AuthorizationURL:NSString = 'https://accounts.google.com/o/oauth2/auth';
    kIDMOAuth2TokenURL:NSString = 'https://accounts.google.com/o/oauth2/token';
    {these items were obtained from the Google API documentation}
    {https://developers.google.com/+/api/oauth}
    kIDMOAuth2ProfileScope:NSString = 'https://www.googleapis.com/auth/userinfo.profile';
    kIDMOAuth2EmailScope:NSString = 'https://www.googleapis.com/auth/userinfo.email';
    {this is just a unique name for the service we are accessing}
    kIDMOAuth2AccountType:NSString = 'Google API';
    {token to look for in Googles response page}
    kIDMOAuth2SuccessPagePrefix:NSString = 'Success';
    kIDMOAuth2ApprovalPagePrefix:NSString = 'oauth2/approval';
  end;


implementation

end.
