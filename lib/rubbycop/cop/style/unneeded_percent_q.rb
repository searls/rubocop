# frozen_string_literal: true

module RubbyCop
  module Cop
    module Style
      # This cop checks for usage of the %q/%Q syntax when '' or "" would do.
      class UnneededPercentQ < Cop
        MSG = 'Use `%s` only for strings that contain both single quotes and ' \
              'double quotes%s.'.freeze
        DYNAMIC_MSG = ', or for dynamic strings that contain ' \
                      'double quotes'.freeze
        SINGLE_QUOTE = "'".freeze
        QUOTE = '"'.freeze
        EMPTY = ''.freeze
        PERCENT_Q = '%q'.freeze
        PERCENT_CAPITAL_Q = '%Q'.freeze
        STRING_INTERPOLATION_REGEXP = /#\{.+}/
        ESCAPED_NON_BACKSLASH = /\\[^\\]/

        def on_dstr(node)
          check(node)
        end

        def on_str(node)
          # Interpolated strings that contain more than just interpolation
          # will call `on_dstr` for the entire string and `on_str` for the
          # non interpolated portion of the string
          return unless string_literal?(node)
          check(node)
        end

        private

        def check(node)
          return unless start_with_percent_q_variant?(node)
          return if interpolated_quotes?(node) || allowed_percent_q?(node)

          add_offense(node, :expression)
        end

        def interpolated_quotes?(node)
          node.source.include?(SINGLE_QUOTE) && node.source.include?(QUOTE)
        end

        def allowed_percent_q?(node)
          node.source.start_with?(PERCENT_Q) && acceptable_q?(node) ||
            node.source.start_with?(PERCENT_CAPITAL_Q) &&
              acceptable_capital_q?(node)
        end

        def message(node)
          src = node.source
          extra = if src.start_with?(PERCENT_CAPITAL_Q)
                    DYNAMIC_MSG
                  else
                    EMPTY
                  end
          format(MSG, src[0, 2], extra)
        end

        def autocorrect(node)
          delimiter =
            node.source =~ /^%Q[^"]+$|'/ ? QUOTE : SINGLE_QUOTE
          lambda do |corrector|
            corrector.replace(node.loc.begin, delimiter)
            corrector.replace(node.loc.end, delimiter)
          end
        end

        def string_literal?(node)
          node.loc.respond_to?(:begin) && node.loc.respond_to?(:end) &&
            node.loc.begin && node.loc.end
        end

        def start_with_percent_q_variant?(string)
          string.source.start_with?(PERCENT_Q, PERCENT_CAPITAL_Q)
        end

        def acceptable_q?(node)
          src = node.source

          return true if src =~ STRING_INTERPOLATION_REGEXP

          src.scan(/\\./).any? { |s| s =~ ESCAPED_NON_BACKSLASH }
        end

        def acceptable_capital_q?(node)
          src = node.source
          src.include?(QUOTE) &&
            (src =~ STRING_INTERPOLATION_REGEXP ||
            (node.str_type? && double_quotes_required?(src)))
        end
      end
    end
  end
end
