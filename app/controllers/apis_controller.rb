class ApisController < ApplicationController
  def show
    fields = parse_fields(params.fetch(:fields))
    users = User.all
    render json: collect_fields(users, fields)
  end

  private

  def parse_fields(string)
    do_parse = ->(chars) do
      obj = []
      word = ''

      loop do
        char = chars.next
        case char
        when ','
          obj << word if word.present?
          word = ''
        when '('
          obj << {word => do_parse.(chars)}
          word = ''
        when ')'
          break
        else
          word << char
        end
      end

      obj << word if word.present?
      obj
    end

    do_parse.(string.each_char)
  end

  def collect_fields(root, fields)
    result = Array.wrap(root).map do |obj|
      fields.each_with_object({}) do |field, agg|
        case field
        when String
          agg[field] = obj.send(field)
        when Hash
          agg[field.keys.first] = collect_fields(obj.send(field.keys.first), field.values.first)
        end
      end
    end

    root.respond_to?(:to_a) ? result : result.first
  end
end
