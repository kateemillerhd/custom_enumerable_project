module Enumerable
    def my_each_with_index
        return to_enum(:my_each_with_index) unless block_given?
        
        index = 0
        self.my_each do |element|
            yield(element, index)
            index += 1
        end
        self
    end

    def my_select
        return to_enum(:my_select) unless block_given?

        result = []
        self.my_each do |element|
            result << element if yield(element)
        end
        result
    end

    def my_all?(pattern = nil)
        self.my_each do |element|
            if block_given?
                return false unless yield(element)
            elsif pattern
	        return false unless pattern === element
            else
                return false unless element
            end
        end
        true
    end

    def my_any?(pattern = nil)
        self.my_each do |element|
            if block_given?
                return true if yield(element)
            elsif pattern
                return true if pattern === element
            else
                return true if element
            end
        end
        false
    end

    def my_none?(pattern = nil)
        self.my_each do |element|
            if block_given?
                return false if yield(element)
            elsif pattern
                return false if pattern === element
            else
                return false if element
            end
        end
        true
    end

    def my_count(item = nil)
        count = 0
        if block_given?
            self.my_each { |element| count += 1 if yield(element) }
        elsif item
            self.my_each { |element| count += 1 if element === item }
        else
            self.my_each { count += 1 }
        end
        count
    end


    def my_map(proc = nil)
        return to_enum(:my_map) unless block_given? || proc
        
        result = []
        if proc
            self.my_each { |element| result << proc.call(element) }
        else
            self.my_each { |element| result << yield(element) }
        end
        result
    end

    def my_inject(*args)
        if args.length == 2
            memo, sym = args
        elsif args.length == 1 && args[0].is_a?(Symbol)
            sym = args[0]
            memo = nil
        else 
            memo = args[0]
        end
        
        self.my_each do |element|
            if memo.nil?
                memo = element
            else
                memo = sym ? memo.send(sym, element) : yield(memo, element)
            end
        end

        memo
    end
end

# You will first have to define my_each
# on the Array class. Methods defined in
# your enumerable module will have access
# to this method




class Array
  # Define my_each here
    def my_each
        return to_enum(:my_each) unless block_given?
        for i in 0...self.length
            yield(self[i])
        end
	self
    end
end
