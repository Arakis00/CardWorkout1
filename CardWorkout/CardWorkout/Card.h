//
//  Card.h
//  CardWorkout
//
//  Created by Brown, Ransom Joseph on 3/23/14.
//  Copyright (c) 2014 Brown, Ransom Joseph. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    Club,
    Spade,
    Heart,
    Diamond
}
Suit;

@interface Card : NSObject

@property (nonatomic, assign, readonly) Suit suit;
@property (nonatomic, assign, readonly) int value;
@property (nonatomic, assign, readonly) int imagePath;

- (id)initWithValues:(Suit)suit value:(int)value imagePath:(int)imagePath;

//accessors
- (int)getImagePath;
- (int)getValue;
- (Suit)getSuit;

@end
