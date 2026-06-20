#A :seed of 0 will make the tests run in the order specified
ExUnit.start(seed: 0)
# The:trace flag makes the test print the names of the individual test
ExUnit.configure(exclude: [:pending, :optional], trace: true)
