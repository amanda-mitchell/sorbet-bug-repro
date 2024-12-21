# typed: strict

require 'sorbet-runtime'

T::Configuration.default_checked_level = :never

# First up, we illustrate a method where the default checked level
# works as expected.
module BasicTest
  extend T::Sig

  sig { params(value: Integer).void }
  def self.test(value)
    # This can be a no-op because we're only testing
    # interactions with the type checker.
  end
end

# Even though this produces a compiler error, it runs just fine
# because we set the default_checked_level to :never.
BasicTest.test('5')

# But if we use the same interface in a struct...
class StructTest < T::Struct
  const :value, Integer
end

# We crash when we try to create an instance with the same value!
StructTest.new(value: '5')
