require './lib/auto_response'

RSpec.describe AutoResponse do
  it "should response the right message depending on the code" do
    message = "Some 111 some"
    response = AutoResponse.instance.respond_to(message)
    expect(response).to eq("Thank you for contacting SMS Care. Our team will contact you soon for a free care referral.")
  end
end

