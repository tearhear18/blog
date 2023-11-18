class UserError < StandardError
    attr_reader :code

    def initialize(message, code)
      @code = code 
      super(message)
    end
end