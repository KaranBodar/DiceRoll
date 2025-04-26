//
//  CornerRadius_Border_Gradient.swift
//  FishingBuddy
//
//  Created by Karan Bodar on 12/04/25.
//

import UIKit

// Apply GradientColor to UIView.

// Steps :-

// 1.Go to Identity Inspector.
// 2.Change class to GradientView.
// 3.Go to properties select the colors , start & end positions & run the program.

import UIKit

@IBDesignable
class GradientView: UIView {

    enum GradientType: String {
        case linear
        case radial
        case circular
        case diamond
    }

    @IBInspectable var startColor: UIColor = .white {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var endColor: UIColor = .black {
        didSet { setNeedsDisplay() }
    }

    @IBInspectable var gradientType: String = "linear" {
        didSet { setNeedsDisplay() }
    }

    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        let type = GradientType(rawValue: gradientType.lowercased()) ?? .linear

        switch type {
        case .linear:
            drawLinearGradient(context: context, rect: rect)
        case .radial, .circular:
            drawRadialGradient(context: context, rect: rect, circular: type == .circular)
        case .diamond:
            drawDiamondGradient(context: context, rect: rect)
        }
    }

    private func drawLinearGradient(context: CGContext, rect: CGRect) {
        let colors = [startColor.cgColor, endColor.cgColor] as CFArray
        let space = CGColorSpaceCreateDeviceRGB()
        let gradient = CGGradient(colorsSpace: space, colors: colors, locations: nil)!

        context.drawLinearGradient(gradient,
                                   start: CGPoint(x: 0, y: 0),
                                   end: CGPoint(x: rect.width, y: rect.height),
                                   options: [])
    }

    private func drawRadialGradient(context: CGContext, rect: CGRect, circular: Bool) {
        let colors = [startColor.cgColor, endColor.cgColor] as CFArray
        let space = CGColorSpaceCreateDeviceRGB()
        guard let gradient = CGGradient(colorsSpace: space, colors: colors, locations: nil) else { return }

        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = sqrt(pow(rect.width / 2, 2) + pow(rect.height / 2, 2))

        context.drawRadialGradient(
            gradient,
            startCenter: center,
            startRadius: 0,
            endCenter: center,
            endRadius: radius,
            options: .drawsAfterEndLocation
        )
    }

    private func drawDiamondGradient(context: CGContext, rect: CGRect) {
        let steps = 100
        for i in 0..<steps {
            let progress = CGFloat(i) / CGFloat(steps)
            let inverseProgress = 1.0 - progress

            // Accessing startColor and endColor correctly
            let color = blend(start: startColor, end: endColor, progress: progress)
            context.setFillColor(color.cgColor)

            let insetX = rect.width * inverseProgress / 2
            let insetY = rect.height * inverseProgress / 2
            let path = UIBezierPath()
            path.move(to: CGPoint(x: rect.midX, y: rect.minY + insetY))
            path.addLine(to: CGPoint(x: rect.maxX - insetX, y: rect.midY))
            path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY - insetY))
            path.addLine(to: CGPoint(x: rect.minX + insetX, y: rect.midY))
            path.close()

            context.addPath(path.cgPath)
            context.fillPath()
        }
    }

    private func blend(start: UIColor, end: UIColor, progress: CGFloat) -> UIColor {
        var sR: CGFloat = 0, sG: CGFloat = 0, sB: CGFloat = 0, sA: CGFloat = 0
        var eR: CGFloat = 0, eG: CGFloat = 0, eB: CGFloat = 0, eA: CGFloat = 0

        start.getRed(&sR, green: &sG, blue: &sB, alpha: &sA)
        end.getRed(&eR, green: &eG, blue: &eB, alpha: &eA)

        let r = sR + (eR - sR) * progress
        let g = sG + (eG - sG) * progress
        let b = sB + (eB - sB) * progress
        let a = sA + (eA - sA) * progress

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }
}




// CornerRadius 1 - Use in Code.

// Apply cornerRadius to UIImage,Button,Lable,TextField.

// Steps :-

// 1.Create Outlet of the object that you want to apply Properties.

// Syntax : self.OutLet.roundCorners(corners: [.topLeft, .bottomRight], radius: 90)

//extension UIView {
//    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
//        let path = UIBezierPath(
//            roundedRect: self.bounds,
//            byRoundingCorners: corners,
//            cornerRadii: CGSize(width: radius, height: radius)
//        )
//
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = path.cgPath
//        self.layer.mask = maskLayer
//    }
//}



// CornerRadius 2 - Use in StoryBoard.

// Steps :-

// 1.Go to StoryBoard -> Properties & apply cornerRadius,BorderWidth & color.

// Apply cornerRadius , borderWidth & borderColor to UIImage,Button,Lable,TextField.

extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        
        get{
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
}
class CornerRadius_Border_Gradient: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    
}
