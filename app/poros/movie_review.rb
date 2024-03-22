class MovieReview 
    attr_reader :author, 
                :summary
                
    def initialize(attributes)
        @author = attributes[:author]
        @summary = attributes[:content]
    end
end