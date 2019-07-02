//
//  User.h
//  twitter
//
//  Created by rgallardo on 7/1/19.
//  Copyright © 2019 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface User : NSObject

//Properties for a user
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
// Additional properties
//...
// Create initializer
- (instancetype) initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END
