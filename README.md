Adds a virtual attribute to models, that plays nice with forms etc


example:

    class MyModel < ActiveRecord::Base
      virtual_attribute :foo, :boolean => true, :attr_type => :attr_accessible
      virtual_attribute :bar, :boolean => true, :attr_type => :attr_accessible
    end

    params = {:foo => '1', :bar => 'false'}
    thing = MyModel.new(params)
  
    thing.foo #=>true
    thing.bar #=> false


Virtual attributes can be set to :boolean => true
  - This will parse ['yes', 'true', '1', 1] to be true
  - and ['no', 'false', '0', 0] to be false
  - otherwise will be nil
  
  - this allows them to be used transparently with checkboxes etc in forms

If using attr_accessible in your model, the virtual attribute should be added to the list to, or you can pass:

    :attr_type => :attr_accessible as an option as shown above

Will document better later, until then:
  phil at latentflip dot com


