//
//  ActionModule.h
//  Prey
//
//  Created by Carlos Yaconi on 11-01-13.
//  Copyright (c) 2013 Fork Ltd. All rights reserved.
//

#import "PreyModule.h"

@interface ActionModule : PreyModule{

}

- (void) notifyCommandResponse:(NSString *)target withStatus: (NSString*)status;

@end
