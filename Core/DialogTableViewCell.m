//
//  DialogTableViewCell.m
//  VKTodayExtension
//
//  Created by  Sergey on 14/12/2016.
//  Copyright © 2016 lisenkov. All rights reserved.
//

#import "DialogTableViewCell.h"

@interface DialogTableViewCell()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageContainer;
@property (weak, nonatomic) IBOutlet UIView  *unreadView;

@end

@implementation DialogTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imageContainer.layer.cornerRadius = self.imageContainer.bounds.size.width /2;
    self.imageContainer.layer.masksToBounds = YES;
    
    self.unreadView.layer.cornerRadius = self.unreadView.bounds.size.width /2;
    self.unreadView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setBody:(NSString *)body
{
    self.bodyLabel.text = body;
}

-(void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

-(void)setImage:(UIImage *)image
{
    self.imageContainer.image = image;
}

-(void)setUnread:(BOOL)isUnread
{
    self.unreadView.hidden = !isUnread;
}

@end
