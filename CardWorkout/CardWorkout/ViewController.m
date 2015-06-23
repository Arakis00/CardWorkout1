//
//  ViewController.m
//  CardWorkout
//
//  Created by Brown, Ransom Joseph on 3/22/14.
//  Copyright (c) 2014 Brown, Ransom Joseph. All rights reserved.
//

/****TODO list****
 add draw animation
 ---add timer---
 ---tally current workout totals---
 create summary
 ability to save and view previous workout history
 revisit previous workouts and attempt to beat time
 add selectable default workouts with different tiers of difficulty
 add ability to create and save custom workouts/exercises
 add joker functionality
 better color scheme
 make/use a more visually appealing interface/graphics
 achievements?
 add section that shows current suit/exercise association?
 make exercise display font resize if input exercise is too long to fit?
 iPad functionality
 */

#import "ViewController.h"
#import "Card.h"

@interface ViewController ()

@property (strong, nonatomic) NSTimer *watchTimer;
@property (strong, nonatomic) NSDate *watchDate;  //stores time first draw button was pressed

@end

@implementation ViewController

@synthesize cardImage; //where card images are displayed
@synthesize cardCountLabel; //shows remaining cards
@synthesize currentExercise; //shows current exercise to perform
@synthesize drawBtn; //button used to draw cards
@synthesize againBtn; //button used to reset form and start another workout
@synthesize finishBtn; //button pressed when all the card actions have been performed
@synthesize total1; //labels to hold exercise repetition totals
@synthesize total2;
@synthesize total3;
@synthesize total4;
@synthesize timer; //label to hold timer


NSMutableArray *cardDeck; //global variable to hold the deck

int cardsLeft = 0; //global variable to hold number of cards in deck


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    cardDeck = [NSMutableArray arrayWithCapacity:cardsLeft]; //setup initial deck capacity
    
    [self createDeck]; //create initial sorted deck
    [self shuffleDeck]; //shuffle the deck
    
    cardCountLabel.text = [NSString stringWithFormat:@"%d", cardsLeft]; //set initial card count value
    
}


//creates a sorted deck of cards
- (void)createDeck
{
    //loop control
    int SUITS = 4; //number of suits
    
    int cardImageCount = 1;//counter that holds which png image to load
    
    //cycle through cards in following order: (Ace, King, Queen, Jack, 10, 9, 8, 7, 6, 5, 4, 3, 2)
    for (int c = 14; c > 1; c--) //c will hold card value
    {
        //cycle through suits in following order: (Club, Spade, Heart, Diamond)
        for (int s = 0; s < SUITS; s++) //s will hold suit value
        {
            Card *tempCard = [[Card alloc] initWithValues:s value:c imagePath:cardImageCount]; //initialize current card
            [cardDeck insertObject:tempCard atIndex:cardsLeft]; //add current card to deck
            
            cardImageCount++; //increment to next image
            cardsLeft++; //increment card counter
        }
        
    }
    
}

//shuffle the deck of cards
- (void)shuffleDeck
{
    NSUInteger count = [cardDeck count]; //array size count
    NSMutableArray *shuffledDeck = [NSMutableArray arrayWithCapacity:count]; //create new array for randomization that is the size of other array
    
    for (int i = 0; i < count; ++i)
    {
        int j = arc4random() % [cardDeck count]; //randomly selecting a card
        Card *card = [cardDeck objectAtIndex:j]; //temp storage for the selected card
        [shuffledDeck addObject:card]; //add card to new shuffled deck
        [cardDeck removeObjectAtIndex:j]; //remove selected card from the original deck
    }
    
    cardDeck = shuffledDeck;  //set global deck to the new shuffled deck
}

//displays which exercise to perform and how many repetitions
- (void)displayExercise
{
    NSString *exercise; //to store exercise to perform
    
    //check card suit and save proper exercise to string to display in label
    if ([[cardDeck objectAtIndex:cardsLeft] getSuit] == 0) //clubs
    {
        exercise = @"Pushups";
        //update total label.....not a great practice to combine UI elements/data, change at some point //TODO
        total1.text = [[NSNumber numberWithInt:([total1.text intValue] + [[cardDeck objectAtIndex:cardsLeft] getValue])] stringValue];
    }
    else if ([[cardDeck objectAtIndex:cardsLeft] getSuit] == 1) //spades
    {
        exercise = @"Pullups";
        //update total label
        total2.text = [[NSNumber numberWithInt:([total2.text intValue] + [[cardDeck objectAtIndex:cardsLeft] getValue])] stringValue];
    }
    else if ([[cardDeck objectAtIndex:cardsLeft] getSuit] == 2) //hearts
    {
        exercise = @"Situps";
        //update total label
        total3.text = [[NSNumber numberWithInt:([total3.text intValue] + [[cardDeck objectAtIndex:cardsLeft] getValue])] stringValue];
    }
    else // it is 3 - diamonds
    {
        exercise = @"Jumping Jacks";
        //update total label
        total4.text = [[NSNumber numberWithInt:([total4.text intValue] + [[cardDeck objectAtIndex:cardsLeft] getValue])] stringValue];
    }
    
    //print out exercise to do
    currentExercise.text = [NSString stringWithFormat:@"%s""%d""%s""%@", "Do ", [[cardDeck objectAtIndex:cardsLeft] getValue],
                            " ", exercise];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
 *** Takes the next card from the stack, displays its' image,
 *** updates count labels, and displays next exercise to
 *** perform.
 */
- (IBAction)drawBtn:(id)sender
{
    if (cardsLeft == 52) //start timer if first card is being drawn
    {
        _watchDate = [NSDate date];
        //set to run at set interval
        _watchTimer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
        [self updateTimer];
    }
    
    --cardsLeft; //decrement number of remaining cards to draw
    //set current card image
    cardImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d", [[cardDeck objectAtIndex:cardsLeft] getImagePath]]];
    //show exercise to perform
    [self displayExercise];
    //put remaining card count in label
    cardCountLabel.text = [NSString stringWithFormat:@"%d", cardsLeft];
    
    
    if (cardsLeft == 0) //on last card
    {
        drawBtn.hidden = true;
        finishBtn.hidden = false;
    }
    
}

- (IBAction)againBtn:(id)sender
{
    againBtn.hidden = true;
    drawBtn.hidden = false;
    
    cardsLeft = 0; //ensure cards are reset to 0
    [self viewDidLoad]; //restart deck setup
    //clear exercise label
    currentExercise.text = @"";
    //clear total labels
    total1.text = [NSString stringWithFormat:@"0"];
    total2.text = [NSString stringWithFormat:@"0"];
    total3.text = [NSString stringWithFormat:@"0"];
    total4.text = [NSString stringWithFormat:@"0"];
    //set image back to card back - b1fv.png
    cardImage.image = [UIImage imageNamed:@"b1fv"];
    //reset timer to 0's
    timer.text = @"0:00:00.0";
    
}

- (IBAction)finishBtn:(id)sender
{
    finishBtn.hidden = true; //hide finish button
    againBtn.hidden = false; //allow user to reshuffle and go again
    
    //stop timer when last exercise is finished
    [_watchTimer invalidate]; //stop looping
    _watchTimer = nil;
    [self updateTimer];
}


- (void) updateTimer
{
    //date from elapsed time
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:_watchDate];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    //date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"H:mm:ss.S"];  
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];  //keeps it from showing 18 at beginning of string
    
    //format elapsed time and set to label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    timer.text = timeString;
}


@end
