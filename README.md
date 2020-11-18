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

".." range is from element x to y\
"..." range is from element x to y, excluding y

#### pushing and popping

`array.push(some_element)` adds an element to the end of the array\
`array.pop` is the removed last element from the end of the array

#### shift and unshift

`array.unshift(some_element)` unshift is like push, but to the beginning of the array\
`array.shift` shift is like pop, but for the beginning of the array


## About Array Assignments

#### Examples

`name = ["Faye", "Cheng"]` => `assert_equal ["Faye", "Cheng"], name`\
`first_name, last_name = ["Faye", "Cheng"]` => `assert_equal "Faye", first_name` and `