
import Foundation
import TRAutocompleteView

@objc class SuggestionItem : NSObject, TRSuggestionItem {
    
    var suggestionText:String
    
    init (completionText:String) {
        self.suggestionText = completionText
    }
    
    class func withText(text:String) -> SuggestionItem {
        var s:SuggestionItem = SuggestionItem(completionText:text)
        return s
    }
    
    func completionText() -> String! {
        return self.suggestionText
    }
    
}
