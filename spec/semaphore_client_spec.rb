require "spec_helper"

RSpec.describe SemaphoreClient do
  it "has a version number" do
    expect(SemaphoreClient::VERSION).not_to be nil
  end
end
