//
//  UIView+Extra.h
//  IBInspectable
//
//  Created by 徐泽宇 on 16/3/8.
//  Copyright © 2016年 徐泽宇. All rights reserved.
//

#import "UIView+IBinspectable.h"
#import <objc/runtime.h>

IB_DESIGNABLE
#define __weakSelf_(__self) __weak __typeof(&*self) __self = self

@implementation UIView (IBinspectable)

- (void)setCornerRadiusOffset:(CGFloat)cornerRadiusOffset {
    self.layer.cornerRadius = cornerRadiusOffset;
    objc_setAssociatedObject(self, @selector(cornerRadiusOffset), @(cornerRadiusOffset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)cornerRadiusOffset {
    return [objc_getAssociatedObject(self, @selector(cornerRadiusOffset)) floatValue];
}

- (void)setCornerRadiusRatio:(CGSize)cornerRadiusRatio {
#if !TARGET_INTERFACE_BUILDER
    // 模拟器真机调用
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(layoutSubviews);
        SEL swizzledSelector = @selector(xxx_layoutSubviews);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
    
   objc_setAssociatedObject(self, @selector(cornerRadiusRatio), NSStringFromCGSize(cornerRadiusRatio), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
#else
    // IB调用
    self.layer.cornerRadius = cornerRadiusRatio.width * self.frame.size.width + cornerRadiusRatio.height * self.frame.size.width + self.cornerRadiusOffset;
#endif
}

- (CGSize)cornerRadiusRatio {
    return CGSizeFromString(objc_getAssociatedObject(self, @selector(cornerRadiusRatio)));
}

- (void)setMasksToBounds:(BOOL)masksToBounds {
    self.layer.masksToBounds = masksToBounds;
}

- (BOOL)masksToBounds {
    return self.layer.masksToBounds;
}

- (void)setBorderColor:(UIColor *)borderColor {
    self.layer.borderColor = borderColor.CGColor;
}

- (UIColor *)borderColor {
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidth {
    return self.layer.borderWidth;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    self.layer.shadowOffset = shadowOffset;
}

- (CGSize)shadowOffset {
    return self.layer.shadowOffset;
}

- (void)setShadowColor:(UIColor *)shadowColor {
    self.layer.shadowColor = shadowColor.CGColor;
}

- (UIColor *)shadowColor {
    return  [UIColor colorWithCGColor:self.layer.shadowColor];
}

- (void)setShadowOpacity:(CGFloat)shadowOpacity {
    self.layer.shadowOpacity = shadowOpacity;
}

- (CGFloat)shadowOpacity {
    return self.layer.shadowOpacity;
}

- (void)setShadowRadius:(CGFloat)shadowRadius {
    self.layer.shadowRadius = shadowRadius;
}

- (CGFloat)shadowRadius {
    return self.layer.shadowRadius;
}

- (void)setContents:(UIImage *)contents {
    self.layer.contents = (id)contents.CGImage;
}

- (UIImage *)contents {
    return [UIImage imageWithCGImage: (CGImageRef)self.layer.contents];
}

#pragma mark - Method Swizzling
- (void)xxx_layoutSubviews {
    self.layer.cornerRadius = self.cornerRadiusRatio.width * self.frame.size.width + self.cornerRadiusRatio.height * self.frame.size.width + self.cornerRadiusOffset;
}

@end
