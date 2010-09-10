class Module
  def virtual_attribute( name, options={} )
    name_equals = "#{name.to_s}="
    inst_var = "@#{name.to_s}"
    module_eval do 

      if options[:boolean] or (options[:type] == :boolean)
        define_method(name_equals) do |val|
          val = val.to_s.strip
          if ['1', 'true', 'yes'].include?(val)
            instance_variable_set(inst_var, true)
          elsif ['0', 'false', 'no'].include?(val)
            instance_variable_set(inst_var, false)
          end
        end
      elsif (options[:type] == :float)
        define_method(name_equals) do |val|
          begin
            instance_variable_set(inst_var, Float(val))
          rescue ArgumentError
            instance_variable_set(inst_var, nil)
          end
        end
      elsif (options[:type] == :integer)
        define_method(name_equals) do |val|
          begin
            instance_variable_set(inst_var, Integer(val))
          rescue ArgumentError
            instance_variable_set(inst_var, nil)
          end
        end
      else
        define_method(name_equals) do |val|
          instance_variable_set(inst_var, val)
        end
      end

      if [:date, :time, :datetime].include? options[:type]
        columns_hash[name.to_s] = ActiveRecord::ConnectionAdapters::Column.new(name.to_s, nil, options[:type].to_s)
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
