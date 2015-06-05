require 'awesome_print'
require 'chronic'

class Array
  def method_missing(meth, *args, &block)
  	from_last = (not ( /last_/ =~ meth.to_s ).nil?)
    ordinal_number = meth.to_s.gsub(/last_/ , "")
    number = Chronic::Numerizer.numerize(ordinal_number.gsub(/_/ , "-")).to_i    

    if number != 0
	  number = self.size - number if from_last
      self.class.class_eval <<-end_eval
        def #{meth}
			return self[ #{number - 1}]
        end
      end_eval
      self.__send__(meth, *args, &block)
    else
      super
    end
  end
end


puts (1..100).to_a.fifty_fifth
puts (1..100).to_a.last_thirdth

