//
//  User.m
//  Prey-iOS
//
//  Created by Carlos Yaconi on 18-03-10.
//  Copyright 2010 Fork Ltd.. All rights reserved.
//

#import "User.h"
#import "PreyRestHttp.h"


@implementation User

@synthesize apiKey;
@synthesize name;
@synthesize country;
@synthesize email;
@synthesize password;
@synthesize repassword;
@synthesize devices;
@synthesize pro;

+ (void)allocWithEmail:(NSString*)emailUser password:(NSString*)passwordUser  withBlock:(void (^)(User *user, NSError *error))block
{
    User *newUser = [[User alloc] init];
	newUser.email = emailUser;
	newUser.password = passwordUser;
    newUser.pro = NO;
    
    
    [[PreyRestHttp getClassVersion] getCurrentControlPanelApiKey:5 withUser:newUser
                                     withBlock:^(NSString *apiKey, NSError *error)
     {
         if (error)
         {
             if (block)
                 block(nil, error);
         }
         else
         {
             [newUser setApiKey:apiKey];
             
             if (block) {
                 block(newUser, nil);
             }
         }
     }];
}

+ (void)getTokenFromPanel:(NSString*)emailUser password:(NSString*)passwordUser  withBlock:(void (^)(NSString *token, NSError *error))block
{
    User *newUser = [[User alloc] init];
    newUser.email = emailUser;
    newUser.password = passwordUser;
    
    [[PreyRestHttp getClassVersion] getTokenFromControlPanel:5 withUser:newUser
                                                       withBlock:^(NSString *token, NSError *error)
     {
         if (error)
             block(nil, error);
         else
             block(token, nil);
     }];
}

+ (void)createNew:(NSString*)nameUser email:(NSString*)emailUser password:(NSString*)passwordUser repassword:(NSString*)repasswordUser  withBlock:(void (^)(User *user, NSError *error))block
{
    User *newUser = [[User alloc] init];
	newUser.pro = NO;
	NSLocale *locale = [NSLocale currentLocale];
    NSString *countryCode = [locale objectForKey: NSLocaleCountryCode];
    NSString *countryName = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
	
	[newUser setName:nameUser];
	[newUser setEmail:emailUser];
	[newUser setCountry:countryName];
	[newUser setPassword:passwordUser];
	[newUser setRepassword:repasswordUser];
	
    [[PreyRestHttp getClassVersion] createApiKey:5 withUser:newUser
                    withBlock:^(NSString *apiKey, NSError *error)
     {
         if (error)
         {
             if (block)
                 block(nil, error);
         }
         else
         {
             [newUser setApiKey:apiKey];
             
             if (block) {
                 block(newUser, nil);
             }
         }
     }];
}

@end
