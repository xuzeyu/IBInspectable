//
//  UIView+Extra.h
//  IBInspectable
//
//  Created by 徐泽宇 on 16/3/8.
//  Copyright © 2016年 徐泽宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (IBinspectable)
/**
 - 两个参数：一个定值，一个按比例；
 - 用两个参数来控制圆角；
 - 定值的参数应该叫 偏移量，在按比例的基础上加偏移量（可正负），默认比例就是0倍
 
 cornerRadiusRatio
 默认都是0,0
 1，-1 就是宽度-高度再+偏移量
 */
@property (assign, nonatomic) IBInspectable CGFloat cornerRadiusOffset; /**< 圆角偏移 */
@property (assign, nonatomic) IBInspectable CGSize  cornerRadiusRatio;  /**< 圆角倍数 */
@property (assign, nonatomic) IBInspectable BOOL masksToBounds;     /**< 视图的图层上的子图层,如果超出父图层的部分就截取掉 */
@property (strong, nonatomic) IBInspectable UIColor *borderColor;   /**< 边框颜色 */
@property (assign, nonatomic) IBInspectable CGFloat borderWidth;    /**< 边框粗细 */

@property (assign, nonatomic) IBInspectable CGSize shadowOffset;    /**< 阴影位移 */
@property (assign, nonatomic) IBInspectable UIColor *shadowColor;   /**< 阴影颜色 */
@property (assign, nonatomic) IBInspectable CGFloat shadowOpacity;  /**< 阴影透明度 */
@property (assign, nonatomic) IBInspectable CGFloat shadowRadius;   /**< 阴影半径 */
@property (assign, nonatomic) IBInspectable UIImage *contents;      /**< layer层图片 */
@end
