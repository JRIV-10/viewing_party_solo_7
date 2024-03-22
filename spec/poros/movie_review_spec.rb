require "rails_helper" 

RSpec.describe MovieReview do 
    describe "#initialize" do 
        it "exists" do 
            attrs = {
                author: "Mark Twain", 
                content: "I Cannot read"
            }

            review = MovieReview.new(attrs)
            
            expect(review.author).to eq("Mark Twain")
            expect(review.summary).to eq("I Cannot read")
        end
    end
end