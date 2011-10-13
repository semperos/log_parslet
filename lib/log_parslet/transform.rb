module LogParslet

  class Transform < Parslet::Transform

    def emit_as_str(ast)
      final_str = ''
      ast.each do |k, v|
        final_str = final_str + v.to_s
      end
      final_str
    end

  end

end
