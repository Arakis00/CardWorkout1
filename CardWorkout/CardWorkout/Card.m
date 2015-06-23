//
//  Card.m
//  CardWorkout
//
//  Created by Brown, Ransom Joseph on 3/23/14.
//  Copyright (c) 2014 Brown, Ransom Joseph. All rights reserved.
//

#import "Card.h"

@implementation Card

@synthesize suit = _suit;
@synthesize value = _value;
@synthesize imagePath = _imagePath;


- (id)initWithValues:(Suit)suit value:(int)value imagePath:(int)imagePath
{
    if ((self = [super init]))
    {
        _suit = suit;
        _value = value;
        _imagePath = imagePath;
    }
    return self;
}

- (int)getImagePath
{
    return _imagePath;
}

- (int)getValue
{
    return _value;
}

- (Suit)getSuit
{
    return _suit;
}

@end
