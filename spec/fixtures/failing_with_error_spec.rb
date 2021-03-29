RSpec.describe "Failing with Error" do
  def foo(a, b)
    a / b
  end

  it "errors" do
    expect(foo(1, 0)).to eq(1)
  end
end
