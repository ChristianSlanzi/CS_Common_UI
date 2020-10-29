//
//  TappableLabel.swift
//  CS_Common_UI
//
//  Created by Christian Slanzi on 29.10.20.
//

import Foundation

public class TappableLabel: UILabel {
    
    let layoutManager = NSLayoutManager()
    let textContainer = NSTextContainer(size: CGSize.zero)
    var textStorage = NSTextStorage() {
        didSet {
            textStorage.addLayoutManager(layoutManager)
        }
    }
    
    public var onCharacterTapped: ((_ label: UILabel, _ characterIndex: Int) -> Void)?
    
    let tapGesture = UITapGestureRecognizer()
    
    public override var attributedText: NSAttributedString? {
        didSet {
            if let attributedText = attributedText {
                textStorage = NSTextStorage(attributedString: attributedText)
            } else {
                textStorage = NSTextStorage()
            }
        }
    }
    
    public override var lineBreakMode: NSLineBreakMode {
        didSet {
            textContainer.lineBreakMode = lineBreakMode
        }
    }
    
    public override var numberOfLines: Int {
        didSet {
            textContainer.maximumNumberOfLines = numberOfLines
        }
    }
    
    /**
     Creates a new view with the passed coder.
     
     :param: aDecoder The a decoder
     
     :returns: the created new view.
     */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    /**
     Creates a new view with the passed frame.
     
     :param: frame The frame
     
     :returns: the created new view.
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    /**
     Sets up the view.
     */
    func setUp() {
        isUserInteractionEnabled = true
        layoutManager.addTextContainer(textContainer)
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = lineBreakMode
        textContainer.maximumNumberOfLines = numberOfLines
        tapGesture.addTarget(self, action: #selector(labelTapped))
        addGestureRecognizer(tapGesture)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        textContainer.size = bounds.size
    }
    
    @objc func labelTapped(gesture: UITapGestureRecognizer) {
        guard gesture.state == .ended else {
            return
        }
        
        let locationOfTouch = gesture.location(in: gesture.view)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x: (bounds.width - textBoundingBox.width) / 2 - textBoundingBox.minX,
                                          y: (bounds.height - textBoundingBox.height) / 2 - textBoundingBox.minY)
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouch.x - textContainerOffset.x,
                                                     y: locationOfTouch.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer,
                                                            in: textContainer,
                                                            fractionOfDistanceBetweenInsertionPoints: nil)
        
        let range = NSRange(location: 0, length: (self.attributedText?.length)!)
        self.attributedText?.enumerateAttribute(NSAttributedString.Key.foregroundColor, in: range,
                                                options: NSAttributedString.EnumerationOptions(rawValue: UInt(0)), using: { (attrs, range, stop) in
            
            if NSLocationInRange(indexOfCharacter, range) {
                if let textAttrs = attrs {
                    
                    //UIApplication.shared.openURL(URL(string: textAttrs as! String)!)
                    
                    //TODO: call injected callback method
                    onCharacterTapped?(self, indexOfCharacter)
                }
            }
        })
    }
}
