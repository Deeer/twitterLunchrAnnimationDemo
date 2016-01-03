//
//  ViewController.swift
//  twitterLunchrAnnimationDemo
//
//  Created by Dee on 16/1/1.
//  Copyright © 2016年 Dee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        //设置遮罩
        let masklayer = CALayer()
        masklayer.contents  = UIImage(named:"logo.png")!.CGImage
        masklayer.frame = CGRectMake(0, 0, backgroundImageView.frame.size.width, backgroundImageView.frame.size.height)
        backgroundImageView.layer.mask = masklayer
        
        //遮罩和背景图之间加一层动画
        let maskView = UIView()
        maskView.frame = CGRectMake(0, 0, 414, 867)
        maskView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(maskView)
        self.view.bringSubviewToFront(maskView)
        UIView .animateWithDuration(0.1, delay: 1.35, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            maskView.alpha = 0.0
            }) { (NilLiteralConvertible) -> Void in
                maskView.removeFromSuperview()
        }
        
        //创建帧动画
        let transform = CAKeyframeAnimation(keyPath: "bounds")
        transform.delegate = self
        transform.duration = 1
        transform.beginTime = CACurrentMediaTime() + 1
        let initalBounds = NSValue(CGRect:  CGRectMake(0, 0, 414, 763))
        let secoundBounds = NSValue(CGRect: CGRectMake(0, 0, 50, 50))
        let finalBounds = NSValue(CGRect:  CGRectMake(0, 0, 2000, 2000))
        transform.values = [initalBounds,secoundBounds,finalBounds]
        transform.keyTimes = [0 ,0.4,1]
        transform.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut),CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)]
//        transform.removedOnCompletion = false
        transform.fillMode = kCAFillModeForwards
        masklayer.addAnimation(transform, forKey:"maskAnimation")
        
        UIView.animateWithDuration(0.25, delay: 1.3, options: UIViewAnimationOptions.TransitionNone, animations: { () -> Void in
            self.backgroundImageView!.transform = CGAffineTransformMakeScale(1.05, 1.05)
            }) { (NilLiteralConvertible) -> Void in
                
        }
    }
    
    /**
     kCAFillModeRemoved:动画结束后，将layer设置回初始的状态,动画开始和结束前对动画都没有影响
     kCAFillModeForwards:动画结束后保持动画最后的状态
     kCAFillModeBackwards:动画开始前，只要将动画加入layer，layer就处于动画的初始状态
     kCAFillModeBoth:动画加入后，立即处于初始状态，动画结束后，保持动画结束状态
     */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

