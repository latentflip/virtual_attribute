class Module
  def virtual_attribute( name, options={} )
    name_equals = "#{name.to_s}="
    inst_var = "@#{name.to_s}"
    module_eval do 

      if options[:boolean]
        define_method(name_equals) do |val|
          val = val.to_s.strip
          if ['1', 'true', 'yes'].include?(val)
            instance_variable_set(inst_var, true)
          elsif ['0', 'false', 'no'].include?(val)
            instance_variable_set(inst_var, false)
          end
        end
      else
        define_method(name_equals) do |val|
          instance_variable_set(inst_var, val)
        end
      end

      define_method(name) do
        instance_variable_get(inst_var)
      end

      if options[:attr_type] && self.respond_to?(options[:attr_type])
        self.send(options[:attr_type], name)
      end
    end
  end
end
