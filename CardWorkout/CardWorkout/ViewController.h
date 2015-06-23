//
//  ViewController.h
//  CardWorkout
//
//  Created by Brown, Ransom Joseph on 3/22/14.
//  Copyright (c) 2014 Brown, Ransom Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UILabel *cardCountLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cardImage;
@property (weak, nonatomic) IBOutlet UILabel *currentExercise;
@property (weak, nonatomic) IBOutlet UIButton *drawBtn;
@property (weak, nonatomic) IBOutlet UIButton *againBtn;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;

//total labels
@property (weak, nonatomic) IBOutlet UILabel *total1;
@property (weak, nonatomic) IBOutlet UILabel *total2;
@property (weak, nonatomic) IBOutlet UILabel *total3;
@property (weak, nonatomic) IBOutlet UILabel *total4;

@property (weak, nonatomic) IBOutlet UILabel *timer;


- (IBAction)drawBtn:(id)sender;
- (IBAction)againBtn:(id)sender;
- (IBAction)finishBtn:(id)sender;


- (void)createDeck;
- (void)shuffleDeck;
- (void)displayExercise;
- (void)updateTimer;



@end
