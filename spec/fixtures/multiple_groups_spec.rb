RSpec.describe "Passing" do
  it "passes" do
    expect(true).to eq(true)
  end
end

RSpec.describe "Failing" do
  it "fails" do
    expect(false).to eq(true)
  end
end
