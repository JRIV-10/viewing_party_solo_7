require "rails_helper" 

RSpec.describe CastMember do
    describe "#initialize" do 
        it "exists" do 
            attrs = {
                name: "Scooby", 
                character: "The best crime stopper"
            }

            bluey = CastMember.new(attrs)

            expect(bluey.name).to eq("Scooby")
            expect(bluey.character).to eq("The best crime stopper")
        end
    end
end