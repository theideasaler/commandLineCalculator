//
//  calc.m
//  calc
//
//  Autor: Wei Liu
//  Student ID: 12489656
//  Date: 18/04/2017
//  Function: Classes Implementation
//  Copyright © 2017 UTS. All rights reserved.
//

#import "calc.h"

@implementation calc

-(BOOL)testNumber:(const char **)inputArray length:(int)length{
    flag=1;
    int b=length-1;
    NSString *input;
    NSMutableArray *tempReceiver = [NSMutableArray array];
    for(int i=0;i<b;i++){//Store the array inputed from terminal to a new array
        input=[NSString stringWithUTF8String:inputArray[i+1]];
       [tempReceiver addObject:input];
    }
    
    if(b==0){// alert when there is no input
        printf("Invalid Input\n");
        flag=0;
        
    }else{//when the input is not empty
        int k=b;
        for(int i=1;i<=k;i++){//check if the inputs are valid inputs
            if(i % 2){//check if odd postion is integer
                NSString *oddNumber=(NSString*)[tempReceiver objectAtIndex:i-1];
                if([[oddNumber substringToIndex:1] isEqualToString:@"+"]||[[oddNumber substringToIndex:1] isEqualToString:@"-"]){//check the input starting with an +/-
                    NSString *integerCheck=[oddNumber substringFromIndex:1];
                    //check if the input is a number
                    NSNumberFormatter *nf=[[NSNumberFormatter alloc]init];
                    BOOL isNumber=[nf numberFromString:integerCheck]!=nil;
                    if([[integerCheck substringToIndex:1] isEqualToString:@"+"]||[[integerCheck substringToIndex:1] isEqualToString:@"-"]){
                        //make sure the input does not start with ++/+-/--/-+
                        printf("Invalid Input:\n");
                        i=k;//break the program
                        flag=0;
                    }else if(isNumber){//the if the input is integer
                        int intCheck=[oddNumber intValue];
                        double doubleCheck=[oddNumber doubleValue];
                        if((intCheck-doubleCheck==0)){//integer check
                            flag=1;
                            self.receiverArray=tempReceiver;
                        }else {
                            printf("Invalid Input");
                            i=k;//break the program
                            flag=0;
                        };
                        
                    }else {printf("Invalid Input:\n");
                        i=k;
                        flag=0;}

                }else{//check the input not starting with +/-
                    NSString *oddNumber=(NSString*)[tempReceiver objectAtIndex:i-1];
                    NSNumberFormatter *nf=[[NSNumberFormatter alloc]init];
                    BOOL isNumber=[nf numberFromString:oddNumber]!=nil;
                    if(isNumber){//number check
                        int intCheck=[oddNumber intValue];
                        double doubleCheck=[oddNumber doubleValue];
                        if((intCheck-doubleCheck==0)){//integer check
                            flag=1;
                            self.receiverArray=tempReceiver;
                        }else {
                            printf("Invalid Input:\n");//not an integer
                            i=k;//break the program
                            flag=0;
                            
                        };
                    }else {printf("Invalid Input:\n");//not a number
                        i=k;
                        flag=0;}
                };
                
            }else{//check if the even position is a valid operator
                 NSString *evenIndex=(NSString*)[tempReceiver objectAtIndex:i-1];
                if ([[tempReceiver objectAtIndex:i-1] isEqualTo:@"+"]||
                    [[tempReceiver objectAtIndex:i-1] isEqualTo:@"-"]||
                    [[tempReceiver objectAtIndex:i-1] isEqualTo:@"x"]||
                    [[tempReceiver objectAtIndex:i-1] isEqualTo:@"/"]||
                    [[tempReceiver objectAtIndex:i-1] isEqualTo:@"%"]
                   )
                {
                    if(k%2==0){//check if the last position is a valid number instead of an operator
                        printf("Invalid Input even1:\n");
                        flag=0;

                    }else {
                        flag=1;
                        self.receiverArray=tempReceiver;
                    }
                    
                }else{//alert when the even position is not an valid input
                    printf("Invalid Input even2:\n");
                    flag=0;
                    i=k;
                };

            }//check if the even position is a valid operator
        }
    }
//**********************************************************************************************************************
        return flag;
}
-(void)calculate:(int)length{//calculate when the input is valid
    int arrayLength=length-1;
    if(arrayLength==1){//return the original value when there is one input
        NSString *firstNumber=(NSString*)[self.receiverArray objectAtIndex:0];
        int result=[firstNumber intValue];
        printf("%d\n",result);
    }else {//calculate the expression when there are more than 2 numbers
        //***********************when there are only plus and subtract operators
        int plusAndsub=1;
        for (int i=1;i<=arrayLength;i++){//calculate the expression when there are only + and  -
            if ((i%2==0)&&(![[self.receiverArray objectAtIndex:i-1] isEqualTo:@"+"]&&![[self.receiverArray objectAtIndex:i-1] isEqualTo:@"-"])){
                plusAndsub=0;
            };
        };
        if(plusAndsub){
            NSString *calcNumber1=(NSString*)[self.receiverArray objectAtIndex:0];
            int sum=[calcNumber1 intValue];
            for(int i=1;i<arrayLength;i=i+2){
                NSString *calcNumber3=(NSString*)[self.receiverArray objectAtIndex:i+1];
                int y=[calcNumber3 intValue];
                if ([[self.receiverArray objectAtIndex:i] isEqualToString:@"+"]){
                    sum=sum+y;
                }else {
                    sum=sum-y;
                };
            };printf("%d\n",sum);
        }else{
            //when there are other operators
            BOOL dividFlag=1;
            for (int i=1;i<=arrayLength;i++){//check if there is a division operator
                if ((i%2==0)&&([[self.receiverArray objectAtIndex:i-1] isEqualTo:@"/"])){
                    if([[self.receiverArray objectAtIndex:i] isEqualTo:@"0"]){//Alert: cannot be divided by zero
                        printf("Cannot be divided by:zero");//print value test
                        i=arrayLength;//break the loop
                        dividFlag=0;
                    };
                };
            };
            
            if(dividFlag){//calculate and store all + and - index
                int arrayNumber=1;
                int largeArray[arrayLength-1];//create an array to save the index
                for (int i=1;i<=arrayLength;i++){
                    if((i%2==0)&&([[self.receiverArray objectAtIndex:i-1] isEqualTo:@"+"]||[[self.receiverArray objectAtIndex:i-1] isEqualTo:@"-"])){
                        largeArray[arrayNumber-1]=i;//save the index number of plus and subtract operator
                        arrayNumber=arrayNumber+1;//separate the whole expression into arrayNumber parts
                    };
                }
                int result=[self seperateCalculate:arrayNumber indexArray:largeArray calcArray:self.receiverArray receivedLength:arrayLength];
                printf("%d\n",result);
            }//dividflag=1
            
        };
        
    }//when there are other operators

};

/*A method created to calculate the small parts separated by plus(+) and subtract(-) operator*/
-(int)seperateCalculate:(int)partNumber indexArray:(int [])positionArray calcArray:(NSMutableArray*)calcArray receivedLength:(int)length{
    int result=0;
    int result1=0;
    int result2=0;
    int result3=0;
    if(partNumber==1){//calculate if there are only one part
        NSString *calcNumber1=(NSString*)[calcArray objectAtIndex:0];
        result=[calcNumber1 intValue];
        for(int i=1;i<length;i=i+2){
            NSString *calcNumber3=(NSString*)[calcArray objectAtIndex:i+1];
            int y=[calcNumber3 intValue];
            if ([[calcArray objectAtIndex:i] isEqualToString:@"x"]){
                result=result*y;
            }else if([[calcArray objectAtIndex:i] isEqualToString:@"/"]){
                result=result/y;
            }else if([[calcArray objectAtIndex:i] isEqualToString:@"%"]){
                result=result%y;
            };
        };//printf("%d\n",result);
       
    }else{//calculate if more than one part
        int results[partNumber-2];
        for(int i=1;i<=partNumber;i++){//calculate the separated parts individually
            if(i==1){//calculate the first part value
                NSString *calcNumber1=(NSString*)[calcArray objectAtIndex:0];
                result1=[calcNumber1 intValue];
                for(int i=1;i<positionArray[0]-1;i=i+2){
                    NSString *calcNumber3=(NSString*)[calcArray objectAtIndex:i+1];
                    int y=[calcNumber3 intValue];
                    if ([[calcArray objectAtIndex:i] isEqualToString:@"x"]){
                        result1=result1*y;
                    }else if([[calcArray objectAtIndex:i] isEqualToString:@"/"]){
                        result1=result1/y;
                    }else if([[calcArray objectAtIndex:i] isEqualToString:@"%"]){
                        result1=result1%y;
                    };
                    
                };

            }else if(i==partNumber){//calculate the last part
                NSString *calcNumber1=(NSString*)[calcArray objectAtIndex:positionArray[partNumber-2]];
                result2=[calcNumber1 intValue];
                for(int i=1;i<length-positionArray[partNumber-2];i=i+2){
                    NSString *calcNumber3=(NSString*)[calcArray objectAtIndex:i+1+positionArray[partNumber-2]];
                    int y=[calcNumber3 intValue];
                    if ([[calcArray objectAtIndex:i+positionArray[partNumber-2]] isEqualToString:@"x"]){
                        result2=result2*y;
                    }else if([[calcArray objectAtIndex:i+positionArray[partNumber-2]] isEqualToString:@"/"]){
                        result2=result2/y;
                    }else if([[calcArray objectAtIndex:i+positionArray[partNumber-2]] isEqualToString:@"%"]){
                        result2=result2%y;
                    };
                    
                };
                int symbol=positionArray[partNumber-2]-1;
                if ([[calcArray objectAtIndex:symbol] isEqualToString:@"+"]){
                   result2=0+result2;
                }else{
                    result2=0-result2;
                };
            }else {//calculate other parts
                NSString *calcNumber1=(NSString*)[calcArray objectAtIndex:positionArray[i-2]];
                results[i]=[calcNumber1 intValue];
                for(int j=1;j<positionArray[i-1]-positionArray[i-2]-1;j=j+2){
                    NSString *calcNumber3=(NSString*)[calcArray objectAtIndex:j+1+positionArray[i-2]];
                    int y=[calcNumber3 intValue];
                    if ([[calcArray objectAtIndex:j+positionArray[i-2]] isEqualToString:@"x"]){
                        results[i]=results[i]*y;
                    }else if([[calcArray objectAtIndex:j+positionArray[i-2]] isEqualToString:@"/"]){
                        results[i]=results[i]/y;
                    }else if([[calcArray objectAtIndex:j+positionArray[i-2]] isEqualToString:@"%"]){
                        results[i]=results[i]%y;
                    };
                };//judge the break point operator is a plus+ or subtract-
                int symbol=positionArray[i-2]-1;
                if ([[calcArray objectAtIndex:symbol] isEqualToString:@"+"]){
                    results[i]=0+results[i];
                }else{
                    results[i]=0-results[i];
                };
            };
        }//top-level for loop
        for (int k=2;k<partNumber;k++){
            result3=result3+results[k];
        };
        result=result1+result2+result3;
    }//more than one part
    return result;
};
@end
