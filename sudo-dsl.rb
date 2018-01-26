class HtmlDsl
  attr_reader :result
  def initialize(&block)
    instance_eval(&block)
  end
 
  private
 
  def method_missing(name, *args, &block)
    tag = name.to_s
    content = args.first
    @result ||= ''
    @result << "<#{tag}>"
    if block_given?
      instance_eval(&block)
    else
      @result << content
    end
    @result << "</#{tag}>"
  end
end
 
 
html = HtmlDsl.new do
  h1 'h1 body'
  h2 'h2 body'
end

p html.result # => "<h1>h1 body</h1><h2>h2 body</h2>"