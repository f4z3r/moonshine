--# selene: allow(undefined_variable, incorrect_standard_library_use)

context("Given simple texts,", function()
  local simple = nil
  before_each(function()
    simple = "hello"
  end)

  describe("when stuff happens, they", function()
    it("should do stuff", function()
      assert.are.equal("hello", simple)
    end)
  end)
end)

