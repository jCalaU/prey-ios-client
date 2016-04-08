//
//  NewModulesConfig.m
//  Prey
//
//  Created by Carlos Yaconi on 11-01-13.
//  Copyright (c) 2013 Fork Ltd. All rights reserved.
//

#import "NewModulesConfig.h"
#import "PreyModule.h"

@implementation NewModulesConfig

- (id) init {
	self = [super init];
	if (self != nil) {
		dataModules = [[NSMutableArray alloc] init];
		actionModules = [[NSMutableArray alloc] init];
        settingModules = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void) addModule: (NSDictionary *) jsonModuleConfig {
    
    PreyLogMessage(@"NewModulesConfig", 10, @"target:%@  command:%@",[jsonModuleConfig objectForKey:@"target"] ,[jsonModuleConfig objectForKey:@"command"]);
    
    PreyModule *module = [PreyModule newModuleForName:[jsonModuleConfig objectForKey:@"target"] andCommand:[jsonModuleConfig objectForKey:@"command"]] ;
    if (module != nil){
        module.command = [jsonModuleConfig objectForKey:@"command"];
        module.options = [jsonModuleConfig objectForKey:@"options"];
        
        if (module.type == DataModuleType)
            [dataModules addObject:module];
        else if (module.type == ActionModuleType)
            [actionModules addObject:module];
        else if (module.type == SettingModuleType)
            [settingModules addObject:module];
    }
}

- (void) runAllModules {
    
    PreyLogMessage(@"NewModulesConfig", 10,@"Run all modules");
    
    PreyModule *module;
    
	for (module in dataModules) {
        if ([module respondsToSelector:NSSelectorFromString(module.command)])
            [module performSelectorOnMainThread:NSSelectorFromString(module.command) withObject:nil waitUntilDone:YES];;
	}
    for (module in actionModules) {
        if ([module respondsToSelector:NSSelectorFromString(module.command)])
            [module performSelectorOnMainThread:NSSelectorFromString(module.command) withObject:nil waitUntilDone:YES];;
	}
    for (module in settingModules) {
        if ([module respondsToSelector:NSSelectorFromString(module.command)])
            [module performSelectorOnMainThread:NSSelectorFromString(module.command) withObject:nil waitUntilDone:YES];;
	}
}
- (BOOL) checkAllModulesEmpty
{
    BOOL isEmpty = NO;
    
    if ( (dataModules.count == 0) && (actionModules.count == 0) && (settingModules.count == 0) )
        isEmpty = YES;

    return isEmpty;
}

@end
