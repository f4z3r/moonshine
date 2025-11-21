local prompt = require("moonshine.prompt")

local string = require("string")

local input = prompt.get_input("Get some standard input:")
print(string.format("You entered '%s'", input))

local password = prompt.get_pass("Enter something secret:")
print(string.format("You entered a password of lenght %d", #password))

while not prompt.confirm("Should we exit") do
  print("Let's try again")
end
