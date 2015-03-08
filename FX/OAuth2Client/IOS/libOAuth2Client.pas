//  Import of libOAuth2Client ()
//  Frameworks:
//  Targets: armv7, armv7s, arm64
//  Dep fx:rtl, Foundation
//  Dep libs:OAuth2Client
namespace ;

interface

type
  OAuth2Client.__Global = public class
  public
    class var NXOAuth2ErrorDomain: NSString;
    class var NXOAuth2InvalidRequestErrorCode: NSInteger;
    class var NXOAuth2InvalidClientErrorCode: NSInteger;
    class var NXOAuth2UnauthorizedClientErrorCode: NSInteger;
    class var NXOAuth2RedirectURIMismatchErrorCode: NSInteger;
    class var NXOAuth2AccessDeniedErrorCode: NSInteger;
    class var NXOAuth2UnsupportedResponseTypeErrorCode: NSInteger;
    class var NXOAuth2InvalidScopeErrorCode: NSInteger;
    class var NXOAuth2CouldNotRefreshTokenErrorCode: NSInteger;
    class var NXOAuth2HTTPErrorDomain: NSString;
    class var NXOAuth2AccountStoreErrorKey: NSString;
    class var NXOAuth2ClientConnectionContextTokenRequest: NSString;
    class var NXOAuth2ClientConnectionContextTokenRefresh: NSString;
    class var NXOAuth2ConnectionDidStartNotification: NSString;
    class var NXOAuth2ConnectionDidEndNotification: NSString;
    class var NXOAuth2AccountStoreDidFailToRequestAccessNotification: NSString;
    class var NXOAuth2AccountStoreAccountsDidChangeNotification: NSString;
    class var NXOAuth2AccountStoreNewAccountUserInfoKey: NSString;
    class var kNXOAuth2AccountStoreConfigurationClientID: NSString;
    class var kNXOAuth2AccountStoreConfigurationSecret: NSString;
    class var kNXOAuth2AccountStoreConfigurationAuthorizeURL: NSString;
    class var kNXOAuth2AccountStoreConfigurationTokenURL: NSString;
    class var kNXOAuth2AccountStoreConfigurationRedirectURL: NSString;
    class var kNXOAuth2AccountStoreConfigurationScope: NSString;
    class var kNXOAuth2AccountStoreConfigurationTokenType: NSString;
    class var kNXOAuth2AccountStoreConfigurationTokenRequestHTTPMethod: NSString;
    class var kNXOAuth2AccountStoreConfigurationAdditionalAuthenticationParameters: NSString;
    class var kNXOAuth2AccountStoreConfigurationCustomHeaderFields: NSString;
    class var kNXOAuth2AccountStoreAccountType: NSString;
    class var NXOAuth2AccountDidChangeUserDataNotification: NSString;
    class var NXOAuth2AccountDidChangeAccessTokenNotification: NSString;
    class var NXOAuth2AccountDidLoseAccessTokenNotification: NSString;
    class var NXOAuth2AccountDidFailToGetAccessTokenNotification: NSString;
    class const NXOAuth2ConnectionDebug: Int32;
  end;

  OAuth2Client.NXOAuth2TrustMode = public enum (
    NXOAuth2TrustModeAnyCertificate,
    AnyCertificate,
    NXOAuth2TrustModeSystem,
    System,
    NXOAuth2TrustModeSpecificCertificate,
    SpecificCertificate
  );

  OAuth2Client.INXOAuth2TrustDelegate = public interface
    method connection(connection: OAuth2Client.NXOAuth2Connection) trustModeForHostname(hostname: NSString): OAuth2Client.NXOAuth2TrustMode;
    method connection(connection: OAuth2Client.NXOAuth2Connection) trustedCertificatesForHostname(hostname: NSString): NSArray;
  end;

  OAuth2Client.INXOAuth2ClientDelegate = public interface
    method oauthClientNeedsAuthentication(client: OAuth2Client.NXOAuth2Client);
    method oauthClientDidGetAccessToken(client: OAuth2Client.NXOAuth2Client);
    method oauthClientDidLoseAccessToken(client: OAuth2Client.NXOAuth2Client);
    method oauthClientDidRefreshAccessToken(client: OAuth2Client.NXOAuth2Client);
    method oauthClient(client: OAuth2Client.NXOAuth2Client) didFailToGetAccessTokenWithError(error: NSError);
  end;

  OAuth2Client.INXOAuth2ConnectionDelegate = public interface
    method oauthConnection(connection: OAuth2Client.NXOAuth2Connection) didReceiveResponse(response: NSURLResponse);
    method oauthConnection(connection: OAuth2Client.NXOAuth2Connection) didFinishWithData(data: NSData);
    method oauthConnection(connection: OAuth2Client.NXOAuth2Connection) didFailWithError(error: NSError);
    method oauthConnection(connection: OAuth2Client.NXOAuth2Connection) didReceiveData(data: NSData);
    method oauthConnection(connection: OAuth2Client.NXOAuth2Connection) didSendBytes(bytesSend: UInt64) ofTotal(bytesTotal: UInt64);
    method oauthConnection(connection: OAuth2Client.NXOAuth2Connection) didReceiveRedirectToURL(redirectURL: NSURL);
  end;

  OAuth2Client.NXOAuth2Client = public class(NSObject)
  protected
    var authenticating: BOOL;
    var persistent: BOOL;
    var clientId: NSString;
    var clientSecret: NSString;
    var desiredScope: NSSet;
    var userAgent: NSString;
    var assertion: NSString;
    var keyChainGroup: NSString;
    var authorizeURL: NSURL;
    var tokenURL: NSURL;
    var tokenType: NSString;
    var authConnection: OAuth2Client.NXOAuth2Connection;
    var accessToken: OAuth2Client.NXOAuth2AccessToken;
    var waitingConnections: NSMutableArray;
    var refreshConnectionDidRetryCount: NSInteger;
    var &delegate: OAuth2Client.INXOAuth2ClientDelegate;
  public
    property authenticating: BOOL read;
    property clientId: NSString read;
    property clientSecret: NSString read;
    property tokenType: NSString read;
    property additionalAuthenticationParameters: NSDictionary read write;
    property customHeaderFields: NSDictionary read write;
    property desiredScope: NSSet read write;
    property tokenRequestHTTPMethod: NSString read write;
    property userAgent: NSString read write;
    property acceptType: NSString read write;
    property accessToken: OAuth2Client.NXOAuth2AccessToken read write;
    property &delegate: OAuth2Client.INXOAuth2ClientDelegate read write;
    property persistent: BOOL read write;
    method initWithClientID(clientId: NSString) clientSecret(clientSecret: NSString) authorizeURL(authorizeURL: NSURL) tokenURL(tokenURL: NSURL) &delegate(&delegate: OAuth2Client.INXOAuth2ClientDelegate): id;
    method initWithClientID(clientId: NSString) clientSecret(clientSecret: NSString) authorizeURL(authorizeURL: NSURL) tokenURL(tokenURL: NSURL) accessToken(accessToken: OAuth2Client.NXOAuth2AccessToken) keyChainGroup(keyChainGroup: NSString) persistent(shouldPersist: BOOL) &delegate(&delegate: OAuth2Client.INXOAuth2ClientDelegate): id;
    method initWithClientID(clientId: NSString) clientSecret(clientSecret: NSString) authorizeURL(authorizeURL: NSURL) tokenURL(tokenURL: NSURL) accessToken(accessToken: OAuth2Client.NXOAuth2AccessToken) tokenType(tokenType: NSString) keyChainGroup(keyChainGroup: NSString) persistent(shouldPersist: BOOL) &delegate(&delegate: OAuth2Client.INXOAuth2ClientDelegate): id;
    method openRedirectURL(URL: NSURL): BOOL;
    method authorizationURLWithRedirectURL(redirectURL: NSURL): NSURL;
    method authenticateWithClientCredentials;
    method authenticateWithUsername(username: NSString) password(password: NSString);
    method authenticateWithAssertionType(assertionType: NSURL) assertion(assertion: NSString);
    method requestAccess;
    method refreshAccessToken;
    method refreshAccessTokenAndRetryConnection(retryConnection: OAuth2Client.NXOAuth2Connection);
  end;

  OAuth2Client.NXOAuth2AccessToken = public class(NSObject)
  private
    var accessToken: NSString;
    var refreshToken: NSString;
    var tokenType: NSString;
    var expiresAt: NSDate;
    var scope: NSSet;
    var responseBody: NSString;
  public
    property accessToken: NSString read;
    property refreshToken: NSString read;
    property tokenType: NSString read;
    property expiresAt: NSDate read;
    property doesExpire: BOOL read;
    property hasExpired: BOOL read;
    property scope: NSSet read;
    property responseBody: NSString read;
    class method tokenWithResponseBody(responseBody: NSString): id;
    class method tokenWithResponseBody(responseBody: NSString) tokenType(tokenType: NSString): id;
    method initWithAccessToken(accessToken: NSString): id;
    method initWithAccessToken(accessToken: NSString) refreshToken(refreshToken: NSString) expiresAt(expiryDate: NSDate): id;
    method initWithAccessToken(accessToken: NSString) refreshToken(refreshToken: NSString) expiresAt(expiryDate: NSDate) scope(scope: NSSet): id;
    method initWithAccessToken(accessToken: NSString) refreshToken(refreshToken: NSString) expiresAt(expiryDate: NSDate) scope(scope: NSSet) responseBody(responseBody: NSString): id;
    method initWithAccessToken(accessToken: NSString) refreshToken(refreshToken: NSString) expiresAt(expiryDate: NSDate) scope(scope: NSSet) responseBody(responseBody: NSString) tokenType(tokenType: NSString): id;
    method restoreWithOldToken(oldToken: OAuth2Client.NXOAuth2AccessToken);
    class method tokenFromDefaultKeychainWithServiceProviderName(provider: NSString): id;
    method storeInDefaultKeychainWithServiceProviderName(provider: NSString);
    method removeFromDefaultKeychainWithServiceProviderName(provider: NSString);
  end;

  OAuth2Client.NXOAuth2ConnectionResponseHandler = public method (response: NSURLResponse; responseData: NSData; error: NSError);

  OAuth2Client.NXOAuth2ConnectionSendingProgressHandler = public method (bytesSend: UInt64; bytesTotal: UInt64);

  OAuth2Client.NXOAuth2Connection = public class(NSObject)
  private
    var connection: NSURLConnection;
    var request: NSMutableURLRequest;
    var response: NSURLResponse;
    var requestParameters: NSDictionary;
    var data: NSMutableData;
    var savesData: BOOL;
    var context: id;
    var userInfo: NSDictionary;
    var client: OAuth2Client.NXOAuth2Client;
    var &delegate: OAuth2Client.INXOAuth2ConnectionDelegate;
    var responseHandler: OAuth2Client.NXOAuth2ConnectionResponseHandler;
    var sendingProgressHandler: OAuth2Client.NXOAuth2ConnectionSendingProgressHandler;
    var sendConnectionDidEndNotification: BOOL;
  public
    property &delegate: OAuth2Client.INXOAuth2ConnectionDelegate read write;
    property data: NSData read;
    property savesData: BOOL read write;
    property expectedContentLength: Int64 read;
    property response: NSURLResponse read;
    property statusCode: NSInteger read;
    property context: id read write;
    property userInfo: NSDictionary read write;
    property client: OAuth2Client.NXOAuth2Client read;
    method initWithRequest(request: NSMutableURLRequest) requestParameters(requestParameters: NSDictionary) oauthClient(client: OAuth2Client.NXOAuth2Client) sendingProgressHandler(sendingProgressHandler: OAuth2Client.NXOAuth2ConnectionSendingProgressHandler) responseHandler(responseHandler: OAuth2Client.NXOAuth2ConnectionResponseHandler): id;
    method initWithRequest(request: NSMutableURLRequest) requestParameters(requestParameters: NSDictionary) oauthClient(client: OAuth2Client.NXOAuth2Client) &delegate(&delegate: OAuth2Client.INXOAuth2ConnectionDelegate): id;
    method cancel;
    method retry;
  end;

  OAuth2Client.NXOAuth2FileStreamWrapper = public class(NSObject)
  protected
    var stream: NSInputStream;
    var contentLength: UInt64;
    var fileName: NSString;
    var contentType: NSString;
  public
    property stream: NSInputStream read;
    property contentLength: UInt64 read;
    property fileName: NSString read;
    property contentType: NSString read write;
    class method wrapperWithStream(stream: NSInputStream) contentLength(contentLength: UInt64): id;
    method initWithStream(stream: NSInputStream) contentLength(contentLength: UInt64): id;
    class method wrapperWithStream(stream: NSInputStream) contentLength(contentLength: UInt64) fileName(fileName: NSString): id;
    method initWithStream(stream: NSInputStream) contentLength(contentLength: UInt64) fileName(fileName: NSString): id;
  end;

  OAuth2Client.NXOAuth2PostBodyStream = public class(NSInputStream)
  protected
    var boundary: NSString;
    var contentStreams: NSArray;
    var currentStream: NSInputStream;
    var streamIndex: NSUInteger;
    var numBytesTotal: UInt64;
  public
    method initWithParameters(postParameters: NSDictionary): id;
    property boundary: NSString read;
    property length: UInt64 read;
  end;

  OAuth2Client.NXOAuth2TrustModeHandler = public method (connection: OAuth2Client.NXOAuth2Connection; hostname: NSString): OAuth2Client.NXOAuth2TrustMode;

  OAuth2Client.NXOAuth2TrustedCertificatesHandler = public method (hostname: NSString): NSArray;

  OAuth2Client.NXOAuth2PreparedAuthorizationURLHandler = public method (preparedURL: NSURL);

  OAuth2Client.NXOAuth2AccountStore = public class(NSObject)
  private
    var pendingOAuthClients: NSMutableDictionary;
    var accountsDict: NSMutableDictionary;
    var configurations: NSMutableDictionary;
    var trustModeHandler: NSMutableDictionary;
    var trustedCertificatesHandler: NSMutableDictionary;
  public
    class method sharedStore: id;
    property accounts: NSArray read;
    method accountsWithAccountType(accountType: NSString): NSArray;
    method accountWithIdentifier(identifier: NSString): OAuth2Client.NXOAuth2Account;
    method setClientID(aClientID: NSString) secret(aSecret: NSString) authorizationURL(anAuthorizationURL: NSURL) tokenURL(aTokenURL: NSURL) redirectURL(aRedirectURL: NSURL) forAccountType(anAccountType: NSString);
    method setClientID(aClientID: NSString) secret(aSecret: NSString) scope(theScope: NSSet) authorizationURL(anAuthorizationURL: NSURL) tokenURL(aTokenURL: NSURL) redirectURL(aRedirectURL: NSURL) keyChainGroup(aKeyChainGroup: NSString) forAccountType(anAccountType: NSString);
    method setClientID(aClientID: NSString) secret(aSecret: NSString) scope(theScope: NSSet) authorizationURL(anAuthorizationURL: NSURL) tokenURL(aTokenURL: NSURL) redirectURL(aRedirectURL: NSURL) keyChainGroup(aKeyChainGroup: NSString) tokenType(aTokenType: NSString) forAccountType(anAccountType: NSString);
    method setConfiguration(configuration: NSDictionary) forAccountType(accountType: NSString);
    method configurationForAccountType(accountType: NSString): NSDictionary;
    method setTrustModeHandlerForAccountType(accountType: NSString) &block(handler: OAuth2Client.NXOAuth2TrustModeHandler);
    method trustModeHandlerForAccountType(accountType: NSString): OAuth2Client.NXOAuth2TrustModeHandler;
    method setTrustedCertificatesHandlerForAccountType(accountType: NSString) &block(handler: OAuth2Client.NXOAuth2TrustedCertificatesHandler);
    method trustedCertificatesHandlerForAccountType(accountType: NSString): OAuth2Client.NXOAuth2TrustedCertificatesHandler;
    method requestAccessToAccountWithType(accountType: NSString);
    method requestAccessToAccountWithType(accountType: NSString) withPreparedAuthorizationURLHandler(aPreparedAuthorizationURLHandler: OAuth2Client.NXOAuth2PreparedAuthorizationURLHandler);
    method requestAccessToAccountWithType(accountType: NSString) username(username: NSString) password(password: NSString);
    method requestAccessToAccountWithType(accountType: NSString) assertionType(assertionType: NSURL) assertion(assertion: NSString);
    method requestClientCredentialsAccessWithType(accountType: NSString);
    method addAccount(account: OAuth2Client.NXOAuth2Account);
    method removeAccount(account: OAuth2Client.NXOAuth2Account);
    method handleRedirectURL(URL: NSURL): BOOL;
  end;

  OAuth2Client.NXOAuth2Account = public class(NSObject)
  private
    var accountType: NSString;
    var identifier: NSString;
    var userData: <anonymous type>;
    var oauthClient: OAuth2Client.NXOAuth2Client;
    var accessToken: OAuth2Client.NXOAuth2AccessToken;
  public
    property accountType: NSString read;
    property identifier: NSString read;
    property userData: <anonymous type> read write;
    property oauthClient: OAuth2Client.NXOAuth2Client read;
    property accessToken: OAuth2Client.NXOAuth2AccessToken read;
  end;

  OAuth2Client.NXOAuth2Request = public class(NSObject)
  private
    var parameters: NSDictionary;
    var resource: NSURL;
    var requestMethod: NSString;
    var account: OAuth2Client.NXOAuth2Account;
    var connection: OAuth2Client.NXOAuth2Connection;
    var me: OAuth2Client.NXOAuth2Request;
  public
    class method performMethod(&method: NSString) onResource(resource: NSURL) usingParameters(parameters: NSDictionary) withAccount(account: OAuth2Client.NXOAuth2Account) sendProgressHandler(progressHandler: OAuth2Client.NXOAuth2ConnectionSendingProgressHandler) responseHandler(responseHandler: OAuth2Client.NXOAuth2ConnectionResponseHandler);
    method initWithResource(url: NSURL) &method(&method: NSString) parameters(parameter: NSDictionary): id;
    property account: OAuth2Client.NXOAuth2Account read write;
    property requestMethod: NSString read write;
    property resource: NSURL read write;
    property parameters: NSDictionary read write;
    method signedURLRequest: NSURLRequest;
    method performRequestWithSendingProgressHandler(progressHandler: OAuth2Client.NXOAuth2ConnectionSendingProgressHandler) responseHandler(responseHandler: OAuth2Client.NXOAuth2ConnectionResponseHandler);
    method cancel;
  end;

implementation

end.
