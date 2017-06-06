//
//  calc.h
//  calc
//
//  Autor: Wei Liu
//  Student ID: 12489656
//  Date: 18/04/2017
//  Function: Classes Declaration
//  Copyright © 2017 UTS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calc:NSObject
{
    BOOL flag;
    char *charTest[4];
    id calculator;
  
}
@property(nonatomic,strong) NSMutableArray *receiverArray;

-(BOOL)testNumber:(const char **)inputArray length:(int)length;//declaration of number test function
-(void)calculate:(int)length;//calculate function

@end

