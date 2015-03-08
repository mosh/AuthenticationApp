//  Import of libOAuth2Client ()
//  Frameworks:
//  Targets: armv7, armv7s, arm64
//  Dep fx:rtl, Foundation
//  Dep libs:OAuth2Client
namespace 
{
    public class OAuth2Client.__Global
    {
        public static NSString NXOAuth2ErrorDomain;
        public static NSInteger NXOAuth2InvalidRequestErrorCode;
        public static NSInteger NXOAuth2InvalidClientErrorCode;
        public static NSInteger NXOAuth2UnauthorizedClientErrorCode;
        public static NSInteger NXOAuth2RedirectURIMismatchErrorCode;
        public static NSInteger NXOAuth2AccessDeniedErrorCode;
        public static NSInteger NXOAuth2UnsupportedResponseTypeErrorCode;
        public static NSInteger NXOAuth2InvalidScopeErrorCode;
        public static NSInteger NXOAuth2CouldNotRefreshTokenErrorCode;
        public static NSString NXOAuth2HTTPErrorDomain;
        public static NSString NXOAuth2AccountStoreErrorKey;
        public static NSString NXOAuth2ClientConnectionContextTokenRequest;
        public static NSString NXOAuth2ClientConnectionContextTokenRefresh;
        public static NSString NXOAuth2ConnectionDidStartNotification;
        public static NSString NXOAuth2ConnectionDidEndNotification;
        public static NSString NXOAuth2AccountStoreDidFailToRequestAccessNotification;
        public static NSString NXOAuth2AccountStoreAccountsDidChangeNotification;
        public static NSString NXOAuth2AccountStoreNewAccountUserInfoKey;
        public static NSString kNXOAuth2AccountStoreConfigurationClientID;
        public static NSString kNXOAuth2AccountStoreConfigurationSecret;
        public static NSString kNXOAuth2AccountStoreConfigurationAuthorizeURL;
        public static NSString kNXOAuth2AccountStoreConfigurationTokenURL;
        public static NSString kNXOAuth2AccountStoreConfigurationRedirectURL;
        public static NSString kNXOAuth2AccountStoreConfigurationScope;
        public static NSString kNXOAuth2AccountStoreConfigurationTokenType;
        public static NSString kNXOAuth2AccountStoreConfigurationTokenRequestHTTPMethod;
        public static NSString kNXOAuth2AccountStoreConfigurationAdditionalAuthenticationParameters;
        public static NSString kNXOAuth2AccountStoreConfigurationCustomHeaderFields;
        public static NSString kNXOAuth2AccountStoreAccountType;
        public static NSString NXOAuth2AccountDidChangeUserDataNotification;
        public static NSString NXOAuth2AccountDidChangeAccessTokenNotification;
        public static NSString NXOAuth2AccountDidLoseAccessTokenNotification;
        public static NSString NXOAuth2AccountDidFailToGetAccessTokenNotification;
        public static const Int32 NXOAuth2ConnectionDebug;
    }

    public enum OAuth2Client.NXOAuth2TrustMode: Int32
    {
        NXOAuth2TrustModeAnyCertificate,
        AnyCertificate,
        NXOAuth2TrustModeSystem,
        System,
        NXOAuth2TrustModeSpecificCertificate,
        SpecificCertificate
    }

    public interface OAuth2Client.INXOAuth2TrustDelegate
    {
        OAuth2Client.NXOAuth2TrustMode connection(OAuth2Client.NXOAuth2Connection connection) trustModeForHostname(NSString hostname);
        NSArray connection(OAuth2Client.NXOAuth2Connection connection) trustedCertificatesForHostname(NSString hostname);
    }

    public interface OAuth2Client.INXOAuth2ClientDelegate
    {
        void oauthClientNeedsAuthentication(OAuth2Client.NXOAuth2Client client);
        void oauthClientDidGetAccessToken(OAuth2Client.NXOAuth2Client client);
        void oauthClientDidLoseAccessToken(OAuth2Client.NXOAuth2Client client);
        void oauthClientDidRefreshAccessToken(OAuth2Client.NXOAuth2Client client);
        void oauthClient(OAuth2Client.NXOAuth2Client client) didFailToGetAccessTokenWithError(NSError error);
    }

    public interface OAuth2Client.INXOAuth2ConnectionDelegate
    {
        void oauthConnection(OAuth2Client.NXOAuth2Connection connection) didReceiveResponse(NSURLResponse response);
        void oauthConnection(OAuth2Client.NXOAuth2Connection connection) didFinishWithData(NSData data);
        void oauthConnection(OAuth2Client.NXOAuth2Connection connection) didFailWithError(NSError error);
        void oauthConnection(OAuth2Client.NXOAuth2Connection connection) didReceiveData(NSData data);
        void oauthConnection(OAuth2Client.NXOAuth2Connection connection) didSendBytes(UInt64 bytesSend) ofTotal(UInt64 bytesTotal);
        void oauthConnection(OAuth2Client.NXOAuth2Connection connection) didReceiveRedirectToURL(NSURL redirectURL);
    }

    public class OAuth2Client.NXOAuth2Client: NSObject
    {
        protected BOOL authenticating;
        protected BOOL persistent;
        protected NSString clientId;
        protected NSString clientSecret;
        protected NSSet desiredScope;
        protected NSString userAgent;
        protected NSString assertion;
        protected NSString keyChainGroup;
        protected NSURL authorizeURL;
        protected NSURL tokenURL;
        protected NSString tokenType;
        protected OAuth2Client.NXOAuth2Connection authConnection;
        protected OAuth2Client.NXOAuth2AccessToken accessToken;
        protected NSMutableArray waitingConnections;
        protected NSInteger refreshConnectionDidRetryCount;
        protected OAuth2Client.INXOAuth2ClientDelegate @delegate;

        public BOOL authenticating { get; }
        public NSString clientId { get; }
        public NSString clientSecret { get; }
        public NSString tokenType { get; }
        public NSDictionary additionalAuthenticationParameters { get; set; }
        public NSDictionary customHeaderFields { get; set; }
        public NSSet desiredScope { get; set; }
        public NSString tokenRequestHTTPMethod { get; set; }
        public NSString userAgent { get; set; }
        public NSString acceptType { get; set; }
        public OAuth2Client.NXOAuth2AccessToken accessToken { get; set; }
        public OAuth2Client.INXOAuth2ClientDelegate @delegate { get; set; }
        public BOOL persistent { get; set; }
        public id initWithClientID(NSString clientId) clientSecret(NSString clientSecret) authorizeURL(NSURL authorizeURL) tokenURL(NSURL tokenURL) @delegate(OAuth2Client.INXOAuth2ClientDelegate @delegate);
        public id initWithClientID(NSString clientId) clientSecret(NSString clientSecret) authorizeURL(NSURL authorizeURL) tokenURL(NSURL tokenURL) accessToken(OAuth2Client.NXOAuth2AccessToken accessToken) keyChainGroup(NSString keyChainGroup) persistent(BOOL shouldPersist) @delegate(OAuth2Client.INXOAuth2ClientDelegate @delegate);
        public id initWithClientID(NSString clientId) clientSecret(NSString clientSecret) authorizeURL(NSURL authorizeURL) tokenURL(NSURL tokenURL) accessToken(OAuth2Client.NXOAuth2AccessToken accessToken) tokenType(NSString tokenType) keyChainGroup(NSString keyChainGroup) persistent(BOOL shouldPersist) @delegate(OAuth2Client.INXOAuth2ClientDelegate @delegate);
        public BOOL openRedirectURL(NSURL URL);
        public NSURL authorizationURLWithRedirectURL(NSURL redirectURL);
        public void authenticateWithClientCredentials();
        public void authenticateWithUsername(NSString username) password(NSString password);
        public void authenticateWithAssertionType(NSURL assertionType) assertion(NSString assertion);
        public void requestAccess();
        public void refreshAccessToken();
        public void refreshAccessTokenAndRetryConnection(OAuth2Client.NXOAuth2Connection retryConnection);
    }

    public class OAuth2Client.NXOAuth2AccessToken: NSObject
    {
        private NSString accessToken;
        private NSString refreshToken;
        private NSString tokenType;
        private NSDate expiresAt;
        private NSSet scope;
        private NSString responseBody;

        public NSString accessToken { get; }
        public NSString refreshToken { get; }
        public NSString tokenType { get; }
        public NSDate expiresAt { get; }
        public BOOL doesExpire { get; }
        public BOOL hasExpired { get; }
        public NSSet scope { get; }
        public NSString responseBody { get; }
        public static id tokenWithResponseBody(NSString responseBody);
        public static id tokenWithResponseBody(NSString responseBody) tokenType(NSString tokenType);
        public id initWithAccessToken(NSString accessToken);
        public id initWithAccessToken(NSString accessToken) refreshToken(NSString refreshToken) expiresAt(NSDate expiryDate);
        public id initWithAccessToken(NSString accessToken) refreshToken(NSString refreshToken) expiresAt(NSDate expiryDate) scope(NSSet scope);
        public id initWithAccessToken(NSString accessToken) refreshToken(NSString refreshToken) expiresAt(NSDate expiryDate) scope(NSSet scope) responseBody(NSString responseBody);
        public id initWithAccessToken(NSString accessToken) refreshToken(NSString refreshToken) expiresAt(NSDate expiryDate) scope(NSSet scope) responseBody(NSString responseBody) tokenType(NSString tokenType);
        public void restoreWithOldToken(OAuth2Client.NXOAuth2AccessToken oldToken);
        public static id tokenFromDefaultKeychainWithServiceProviderName(NSString provider);
        public void storeInDefaultKeychainWithServiceProviderName(NSString provider);
        public void removeFromDefaultKeychainWithServiceProviderName(NSString provider);
    }

    public     public void (NSURLResponse response, NSData responseData, NSError error);

    public     public void (UInt64 bytesSend, UInt64 bytesTotal);

    public class OAuth2Client.NXOAuth2Connection: NSObject
    {
        private NSURLConnection connection;
        private NSMutableURLRequest request;
        private NSURLResponse response;
        private NSDictionary requestParameters;
        private NSMutableData data;
        private BOOL savesData;
        private id context;
        private NSDictionary userInfo;
        private OAuth2Client.NXOAuth2Client client;
        private OAuth2Client.INXOAuth2ConnectionDelegate @delegate;
        private OAuth2Client.NXOAuth2ConnectionResponseHandler responseHandler;
        private OAuth2Client.NXOAuth2ConnectionSendingProgressHandler sendingProgressHandler;
        private BOOL sendConnectionDidEndNotification;

        public OAuth2Client.INXOAuth2ConnectionDelegate @delegate { get; set; }
        public NSData data { get; }
        public BOOL savesData { get; set; }
        public Int64 expectedContentLength { get; }
        public NSURLResponse response { get; }
        public NSInteger statusCode { get; }
        public id context { get; set; }
        public NSDictionary userInfo { get; set; }
        public OAuth2Client.NXOAuth2Client client { get; }
        public id initWithRequest(NSMutableURLRequest request) requestParameters(NSDictionary requestParameters) oauthClient(OAuth2Client.NXOAuth2Client client) sendingProgressHandler(OAuth2Client.NXOAuth2ConnectionSendingProgressHandler sendingProgressHandler) responseHandler(OAuth2Client.NXOAuth2ConnectionResponseHandler responseHandler);
        public id initWithRequest(NSMutableURLRequest request) requestParameters(NSDictionary requestParameters) oauthClient(OAuth2Client.NXOAuth2Client client) @delegate(OAuth2Client.INXOAuth2ConnectionDelegate @delegate);
        public void cancel();
        public void retry();
    }

    public class OAuth2Client.NXOAuth2FileStreamWrapper: NSObject
    {
        protected NSInputStream stream;
        protected UInt64 contentLength;
        protected NSString fileName;
        protected NSString contentType;

        public NSInputStream stream { get; }
        public UInt64 contentLength { get; }
        public NSString fileName { get; }
        public NSString contentType { get; set; }
        public static id wrapperWithStream(NSInputStream stream) contentLength(UInt64 contentLength);
        public id initWithStream(NSInputStream stream) contentLength(UInt64 contentLength);
        public static id wrapperWithStream(NSInputStream stream) contentLength(UInt64 contentLength) fileName(NSString fileName);
        public id initWithStream(NSInputStream stream) contentLength(UInt64 contentLength) fileName(NSString fileName);
    }

    public class OAuth2Client.NXOAuth2PostBodyStream: NSInputStream
    {
        protected NSString boundary;
        protected NSArray contentStreams;
        protected NSInputStream currentStream;
        protected NSUInteger streamIndex;
        protected UInt64 numBytesTotal;

        public id initWithParameters(NSDictionary postParameters);

        public NSString boundary { get; }
        public UInt64 length { get; }
    }

    public     public OAuth2Client.NXOAuth2TrustMode (OAuth2Client.NXOAuth2Connection connection, NSString hostname);

    public     public NSArray (NSString hostname);

    public     public void (NSURL preparedURL);

    public class OAuth2Client.NXOAuth2AccountStore: NSObject
    {
        private NSMutableDictionary pendingOAuthClients;
        private NSMutableDictionary accountsDict;
        private NSMutableDictionary configurations;
        private NSMutableDictionary trustModeHandler;
        private NSMutableDictionary trustedCertificatesHandler;

        public static id sharedStore();

        public NSArray accounts { get; }
        public NSArray accountsWithAccountType(NSString accountType);
        public OAuth2Client.NXOAuth2Account accountWithIdentifier(NSString identifier);
        public void setClientID(NSString aClientID) secret(NSString aSecret) authorizationURL(NSURL anAuthorizationURL) tokenURL(NSURL aTokenURL) redirectURL(NSURL aRedirectURL) forAccountType(NSString anAccountType);
        public void setClientID(NSString aClientID) secret(NSString aSecret) scope(NSSet theScope) authorizationURL(NSURL anAuthorizationURL) tokenURL(NSURL aTokenURL) redirectURL(NSURL aRedirectURL) keyChainGroup(NSString aKeyChainGroup) forAccountType(NSString anAccountType);
        public void setClientID(NSString aClientID) secret(NSString aSecret) scope(NSSet theScope) authorizationURL(NSURL anAuthorizationURL) tokenURL(NSURL aTokenURL) redirectURL(NSURL aRedirectURL) keyChainGroup(NSString aKeyChainGroup) tokenType(NSString aTokenType) forAccountType(NSString anAccountType);
        public void setConfiguration(NSDictionary configuration) forAccountType(NSString accountType);
        public NSDictionary configurationForAccountType(NSString accountType);
        public void setTrustModeHandlerForAccountType(NSString accountType) block(OAuth2Client.NXOAuth2TrustModeHandler handler);
        public OAuth2Client.NXOAuth2TrustModeHandler trustModeHandlerForAccountType(NSString accountType);
        public void setTrustedCertificatesHandlerForAccountType(NSString accountType) block(OAuth2Client.NXOAuth2TrustedCertificatesHandler handler);
        public OAuth2Client.NXOAuth2TrustedCertificatesHandler trustedCertificatesHandlerForAccountType(NSString accountType);
        public void requestAccessToAccountWithType(NSString accountType);
        public void requestAccessToAccountWithType(NSString accountType) withPreparedAuthorizationURLHandler(OAuth2Client.NXOAuth2PreparedAuthorizationURLHandler aPreparedAuthorizationURLHandler);
        public void requestAccessToAccountWithType(NSString accountType) username(NSString username) password(NSString password);
        public void requestAccessToAccountWithType(NSString accountType) assertionType(NSURL assertionType) assertion(NSString assertion);
        public void requestClientCredentialsAccessWithType(NSString accountType);
        public void addAccount(OAuth2Client.NXOAuth2Account account);
        public void removeAccount(OAuth2Client.NXOAuth2Account account);
        public BOOL handleRedirectURL(NSURL URL);
    }

    public class OAuth2Client.NXOAuth2Account: NSObject
    {
        private NSString accountType;
        private NSString identifier;
        private void userData;
        private OAuth2Client.NXOAuth2Client oauthClient;
        private OAuth2Client.NXOAuth2AccessToken accessToken;

        public NSString accountType { get; }
        public NSString identifier { get; }
        public void userData { get; set; }
        public OAuth2Client.NXOAuth2Client oauthClient { get; }
        public OAuth2Client.NXOAuth2AccessToken accessToken { get; }
    }

    public class OAuth2Client.NXOAuth2Request: NSObject
    {
        private NSDictionary parameters;
        private NSURL resource;
        private NSString requestMethod;
        private OAuth2Client.NXOAuth2Account account;
        private OAuth2Client.NXOAuth2Connection connection;
        private OAuth2Client.NXOAuth2Request me;

        public static void performMethod(NSString method) onResource(NSURL resource) usingParameters(NSDictionary parameters) withAccount(OAuth2Client.NXOAuth2Account account) sendProgressHandler(OAuth2Client.NXOAuth2ConnectionSendingProgressHandler progressHandler) responseHandler(OAuth2Client.NXOAuth2ConnectionResponseHandler responseHandler);
        public id initWithResource(NSURL url) method(NSString method) parameters(NSDictionary parameter);

        public OAuth2Client.NXOAuth2Account account { get; set; }
        public NSString requestMethod { get; set; }
        public NSURL resource { get; set; }
        public NSDictionary parameters { get; set; }
        public NSURLRequest signedURLRequest();
        public void performRequestWithSendingProgressHandler(OAuth2Client.NXOAuth2ConnectionSendingProgressHandler progressHandler) responseHandler(OAuth2Client.NXOAuth2ConnectionResponseHandler responseHandler);
        public void cancel();
    }
}
