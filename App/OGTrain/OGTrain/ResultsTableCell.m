//
//  ResultsTableCell.m
//  OGTrain
//
//  Created by Manav Kohli on 12/10/15.
//  Copyright (c) 2015 Manav Kohli. All rights reserved.
//

#import "ResultsTableCell.h"

@implementation ResultsTableCell
@synthesize nameLabel = _nameLabel;
@synthesize categoryLabel = _prepTimeLabel;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
