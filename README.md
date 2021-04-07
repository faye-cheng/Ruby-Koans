# Learnings and Notes

## About Asserts

#### assert equality of two values

You can use the keyword assert in `assert a == b`.\
But it is better practice to use assert_equal in `assert_equal c, d`


## About Nil

Ruby uses nil instead of null in other languages

If you `nil.inspect` you get "nil"

#### NoMethodError when calling method on nil

 Example:

```
begin
  nil.some_method_nil_doesnt_know_about
  rescue Exception => ex
    assert_equal NoMethodError, ex.class
    assert_match(/__/, ex.message)
end
```

You can call ex.class and ex.message to validate

**Gotcha**: assert_match expect regex match, got a "type mismatch: String given" error because I thought the message was a String. It actually expects a regex match and therefore needed to be within "/.../" like:

  `assert_match(/undefined method 'some_method_nil_doesnt_know_about' for nil:NilClass/, ex.message)`

- `nil.nil?`      checks if nil, boolean
- `nil.to_s`      nil to string is ""
- `nil.inspect`   "nil"


## About Objects

#### Everything is an object

Examples: 1, 1.5, "string", nil, Object

You can verify by `some_element.is_a?(Object)`

#### Every object has an id

#### obj.clone

You can clone objects by `.clone` and this will result in a new object with a different object ID


## About Arrays

#### adding elements

`array << some_element`
`array[1] = some_element`

#### accessing elements

- `array.first`
- `array.last`
- `array[-1]` negative element loops from 0 to the other end of array

#### slicing

[start, length] aka array position, elements after start

If you have an array with 4 elements:

`array = [:peanut, :butter, :and, :jelly]`

Why is `array[4,0] == []` while `array[5,0] == nil`?

This is because of how slicing works, it is inbetween elements in an array. So in this case, technically 4 is within the slicing range and is valid, while 5 is outside and invalid.

#### ranges

Range is a class type, `[1,2,3,4,5]` and `(1..5)` are not equal

`(1..5).to_a is [1, 2, 3, 4, 5]` while `(1...5).to_a is [1, 2, 3, 4]`

`..` range is from element x to y\
`...` range is from element x to y, excluding y

#### pushing and popping

`array.push(some_element)` adds an element to the end of the array\
`array.pop` is the removed last element from the end of the array

#### shift and unshift

`array.unshift(some_element)` unshift is like push, but to the beginning of the array\
`array.shift` shift is like pop, but for the beginning of the array


## About Array Assignments

#### examples

- `name = ["Faye", "Cheng"]` => `assert_equal ["Faye", "Cheng"], name`
- `first_name, last_name = ["Faye", "Cheng"]` => `assert_equal "Faye", first_name` and `assert_equal "Cheng", last_name`
- `name, = ["Faye", "Cheng"]` => `assert_equal "Faye", name` (This is tricky, the comma makes it a parallel assignment, so Cheng gets dropped)
- `first_name, last_name = ["Faye"]` => `assert_equal "Faye", first_name` and `assert_equal nil, last_name` (first_name was declared first)

#### splat

You can use the splat operator whenever you don't want to specify the num of args you have.\
`*args` means "gooble up remaining args in an array and bind them to the parameter named `args`"\
`*` means "gobble up all the remaining args and bind them to nothing, ignore all remaining args"



## About Hashes

- `empty_hash = Hash.new` creates a new hash
- `{}` is an empty hash
- hashes are unordered

#### fetch

Returns a value from the hash for the given key. If the key can’t be found, there are several options: With no other arguments, it will raise a KeyError exception; if default is given, then that will be returned; if the optional code block is specified, then that will be run and its result returned. (https://apidock.com/ruby/Hash/fetch)

You can specify a default value by:

```
{a: false}.fetch(:b, true)
=> true
{a: false}.fetch(:a, true)
=> false
```

Q: Why might you want to use #fetch instead of #[] when accessing hash keys?

- with [], the creator of the hash controls what happens when a key does not exist, with fetch you do
- if the missing key is exception-worthy, then it is better to return an exception instead of nil

#### changing hashes

Q: Why was "expected" broken out into a variable rather than used as a literal?

- Because you cannot do something like `assert_equal { :one => "eins", :two => "dos" }, hash`
Ruby thinks that { ... } is a block, so it should be "broken out into a variable", but you can always use assert_equal({ :one => "eins", :two => "dos" }, hash)

#### hash keys & values

- `hash.keys.include?` tells you if a given key exists in the hash
- `hash.values.include?` tells you if a given value exists in the hash
- `hash.keys.size` tells you how many keys are in the hash
- `hash.values.size` tells you how many values are in the hash

- Given a hash `hash = { :one => "uno", :two => "dos" }` then `hash.keys.class` is Array

#### combining hashes

- use `.merge()` to combine two hashes and return a new hash (https://apidock.com/ruby/Hash/merge)
- example:

```
hash = { "jim" => 53, "amy" => 20, "dan" => 23 }
new_hash = hash.merge({ "jim" => 54, "jenny" => 26 })

expected = { "jim" => 54, "amy" => 20, "dan" => 23, "jenny" => 26 }
assert_equal true, expected == new_hash
```

If there are duplicate keys for the hashes being merged but with different values, then the value of the other_hash takes priority. You see that above where the value for "jim" is 54 instead of 53 in the new hash.

#### default values

You can create a default value by `hash = Hash.new("dos")` so if you do `hash[:two]` which is a key that does not exist yet, you get back "dos" since it was defaulted. Without the default value, if you did `hash = Hash.new`, then `hash[:two]` will give you nil.


#### default value is the same object

- `hash = Hash.new([])` will instantiate a new array with [] then make a hash with [] as its default
- `hash[:one] << "uno"` will add "uno" to the default []
- `hash[:two] << "dos` will add "dos" to the default [] which now contains "uno"

If you wanted the code to behave like you think it should, with a different array in each key, you need to return a new array every time you want a default, not Harvey every single time:

`hash = Hash.new { |h, k| h[k] = [] }`

or better yet, if you don't want the hash to deal with arrays then just use this pattern: `hash[:one] = "uno"`