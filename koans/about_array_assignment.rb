require File.expand_path(File.dirname(__FILE__) + '/neo')

class AboutArrayAssignment < Neo::Koan
  def test_non_parallel_assignment
    names = ["John", "Smith"]
    assert_equal ["John", "Smith"], names
  end

  def test_parallel_assignments
    first_name, last_name = ["John", "Smith"]
    assert_equal "John", first_name
    assert_equal "Smith", last_name
  end

  def test_parallel_assignments_with_extra_values   ## Then what assignment is "III" if undefined?
    first_name, last_name = ["John", "Smith", "III"]
    assert_equal "John", first_name
    assert_equal "Smith", last_name
  end

  ## I think nothing if undefined but need to double check

  def test_parallel_assignments_with_splat_operator   ## What is splat operator?
    first_name, *last_name = ["John", "Smith", "III"]
    assert_equal "John", first_name
    assert_equal ["Smith", "III"], last_name
  end

  ## You can use the splat operator whenever you don't want to specify the num of args you have.
  ## `*args` means "gooble up remaining args in an array and bind them to the parameter named `args`"
  ## `*` means "gobble up all the remaining args and bind them to nothing, ignore all remaining args"

  def test_parallel_assignments_with_too_few_variables
    first_name, last_name = ["Cher"]
    assert_equal "Cher", first_name
    assert_equal nil, last_name ## nil because not defined, first_name declared first
  end

  def test_parallel_assignments_with_subarrays
    first_name, last_name = [["Willie", "Rae"], "Johnson"]
    assert_equal ["Willie", "Rae"], first_name
    assert_equal "Johnson", last_name
  end

  def test_parallel_assignment_with_one_variable
    first_name, = ["John", "Smith"] ## Note the ","
    assert_equal "John", first_name
  end

  ## Without the comma, first_name would be ["John", "Smith"]
  ## However, since there is a comma that means you treat it like a parallel assignment

  def test_swapping_with_parallel_assignment
    first_name = "Roy"
    last_name = "Rob"
    first_name, last_name = last_name, first_name
    assert_equal "Rob", first_name
    assert_equal "Roy", last_name
  end
end
