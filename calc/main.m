//
//  main.m
//  calc
//
//  Autor: Wei Liu
//  Student ID: 12489656
//  Date: 18/04/2017
//  Function: Command line caculator
//

#import "calc.h"
#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        @try {
            calc *calculator=[[calc alloc]init];
            int flag=[calculator testNumber:argv length:argc];//continue if the input is valid
            if(flag){
                [calculator calculate:argc];//use calculate function to get result
            }

        } @catch (NSException * e) {
            printf("---Invalid Input---");
        }
    }
    return 0;
}
