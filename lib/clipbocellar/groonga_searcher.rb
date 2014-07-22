module Clipbocellar
  class GroongaSearcher
    class << self
      def search(database, words, options)
        clipboards = database.clipboards
        clipboards = clipboards.select do |clipboard|
          expression = nil
          words.each do |word|
            sub_expression = (clipboard.text =~ word)
            if expression.nil?
              expression = sub_expression
            else
              expression &= sub_expression
            end
          end

          if options[:mtime]
            base_date = (Time.now - (options[:mtime] * 60 * 60 * 24))
            mtime_expression = clipboard.date > base_date
            if expression.nil?
              expression = mtime_expression
            else
              expression &= mtime_expression
            end
          end

          expression
        end

        order = options[:reverse] ? "ascending" : "descending"
        sorted_clipboards = clipboards.sort([{:key => "date", :order => order}])

        sorted_clipboards
      end
    end
  end
end
