# Learnings and Notes

## About Asserts

#### assert equality of two values

You can use the keyword *assert* in `assert a == b`, but it is better practice to use *assert_equal* in `assert_equal c, d`

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

#### test_nil_has_a_few_methods_defined_on_it

- `nil.nil?`      checks if nil, boolean
- `nil.to_s`      nil to string is ""
- `nil.inspect`   "nil"

**Q**: Look into `.inspect` and what it does

## About Objects

#### Everything is an object

- `assert_equal true, 1.is_a?(Object)`
- `assert_equal true, 1.5.is_a?(Object)`
- `assert_equal __, "string".is_a?(Object)`
- `assert_equal __, nil.is_a?(Object)`
- `assert_equal __, Object.is_a?(Object)`

#### Every object has an id

```
def test_every_object_has_an_id
  obj = Object.new
  assert_equal Integer, obj.object_id.class
end
```

#### test_small_integers_have_fixed_ids

- `assert_equal 1, 0.object_id`   
- `assert_equal 3, 1.object_id`
- `assert_equal 5, 2.object_id`
- `assert_equal 201, 100.object_id`

Object IDs for small integers follow this pattern for x: x.object_id is **2x + 1**

#### obj.clone

You can clone objects by `.clone` and this will result in a new object with a different object ID
