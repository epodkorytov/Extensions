//
//  UITextView+Extension.swift
//  Extensions
//


import UIKit

extension UITextView: UITextViewDelegate {
    
//    MARK: Constants
    
    static let PLACEHOLDER_VIEW_TAG = 999
    
    
//    MARK: - Variables
    
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = viewWithTag(UITextView.PLACEHOLDER_VIEW_TAG) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = viewWithTag(UITextView.PLACEHOLDER_VIEW_TAG) as! UILabel? {
                placeholderLabel.text = newValue
                resizePlaceholder()
            } else {
                addPlaceholder(newValue!)
            }
        }
    }
    
    public var placeholderColor: UIColor? {
        get {
            var result: UIColor?
            
            if let placeholderLabel = viewWithTag(UITextView.PLACEHOLDER_VIEW_TAG) as? UILabel {
                result = placeholderLabel.textColor
            }
            
            return result
        }
        set {
            if let placeholderLabel = viewWithTag(UITextView.PLACEHOLDER_VIEW_TAG) as! UILabel? {
                placeholderLabel.textColor = newValue
            } else {
                addPlaceholder("", color: newValue)
            }
        }
    }
    
    
//    MARK: - Overriden methods
    
    override open var bounds: CGRect {
        didSet {
            resizePlaceholder()
        }
    }
    
    
//    MARK: - Private methods
    
    private func resizePlaceholder() {
        if let placeholderLabel = viewWithTag(UITextView.PLACEHOLDER_VIEW_TAG) as! UILabel? {
            let labelX = textContainer.lineFragmentPadding
            let labelY = textContainer.lineFragmentPadding == 0.0 ? 0.0 : textContainerInset.top - 2
            let labelWidth = frame.width - (labelX * 2)
            var labelHeight = frame.height - (labelY * 2)
            if let text = placeholderLabel.text {
                labelHeight = text.height(withConstrainedWidth: labelWidth, font: placeholderLabel.font)
            }
            
            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    private func addPlaceholder(_ placeholderText: String, color: UIColor? = .lightGray) {
        let placeholderLabel = UILabel()
        
        placeholderLabel.text = placeholderText
        placeholderLabel.numberOfLines = 0
        
        placeholderLabel.font = font
        placeholderLabel.textColor = color
        placeholderLabel.tag = UITextView.PLACEHOLDER_VIEW_TAG
        
        placeholderLabel.isHidden = text.count > 0
        
        addSubview(placeholderLabel)
        resizePlaceholder()
        delegate = self
    }
    
    
//    MARK: - Interface methods
    
    public func hidePlaceholderLabel() {
        if let placeholderLabel = viewWithTag(UITextView.PLACEHOLDER_VIEW_TAG) as? UILabel {
            placeholderLabel.isHidden = text.count > 0
        }
    }
    
    
//    MARK: - Delegated methods

//    MARK: UITextViewDelegate
    
    public func textViewDidChange(_ textView: UITextView) {
        hidePlaceholderLabel()
    }
    
    
}

