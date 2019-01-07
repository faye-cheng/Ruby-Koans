# Learnings and Notes

## About Asserts

#### assert equality of two values

You can use the keyword *assert* in `assert a == b`, but it is better practice to use *assert_equal* in `assert_equal c, d`

## About Nil

Ruby uses nil instead of null in other languages

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
