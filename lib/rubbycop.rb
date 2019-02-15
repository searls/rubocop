# frozen_string_literal: true

require 'parser'
require 'rainbow'

require 'English'
require 'set'
require 'powerpack/array/butfirst'
require 'powerpack/enumerable/drop_last'
require 'powerpack/hash/symbolize_keys'
require 'powerpack/string/blank'
require 'powerpack/string/strip_indent'
require 'unicode/display_width'

require 'rubbycop/version'

require 'rubbycop/path_util'
require 'rubbycop/platform'
require 'rubbycop/string_util'
require 'rubbycop/name_similarity'
require 'rubbycop/node_pattern'
require 'rubbycop/string_interpreter'
require 'rubbycop/ast/sexp'
require 'rubbycop/ast/node'
require 'rubbycop/ast/node/mixin/binary_operator_node'
require 'rubbycop/ast/node/mixin/conditional_node'
require 'rubbycop/ast/node/mixin/hash_element_node'
require 'rubbycop/ast/node/mixin/modifier_node'
require 'rubbycop/ast/node/mixin/predicate_operator_node'
require 'rubbycop/ast/node/and_node'
require 'rubbycop/ast/node/array_node'
require 'rubbycop/ast/node/case_node'
require 'rubbycop/ast/node/ensure_node'
require 'rubbycop/ast/node/for_node'
require 'rubbycop/ast/node/hash_node'
require 'rubbycop/ast/node/if_node'
require 'rubbycop/ast/node/keyword_splat_node'
require 'rubbycop/ast/node/or_node'
require 'rubbycop/ast/node/pair_node'
require 'rubbycop/ast/node/resbody_node'
require 'rubbycop/ast/node/send_node'
require 'rubbycop/ast/node/until_node'
require 'rubbycop/ast/node/when_node'
require 'rubbycop/ast/node/while_node'
require 'rubbycop/ast/builder'
require 'rubbycop/ast/traversal'
require 'rubbycop/error'
require 'rubbycop/warning'

require 'rubbycop/cop/util'
require 'rubbycop/cop/offense'
require 'rubbycop/cop/message_annotator'
require 'rubbycop/cop/ignored_node'
require 'rubbycop/cop/autocorrect_logic'
require 'rubbycop/cop/badge'
require 'rubbycop/cop/registry'
require 'rubbycop/cop/cop'
require 'rubbycop/cop/commissioner'
require 'rubbycop/cop/corrector'
require 'rubbycop/cop/force'
require 'rubbycop/cop/severity'

require 'rubbycop/cop/variable_force'
require 'rubbycop/cop/variable_force/branch'
require 'rubbycop/cop/variable_force/branchable'
require 'rubbycop/cop/variable_force/variable'
require 'rubbycop/cop/variable_force/assignment'
require 'rubbycop/cop/variable_force/reference'
require 'rubbycop/cop/variable_force/scope'
require 'rubbycop/cop/variable_force/variable_table'

require 'rubbycop/cop/mixin/access_modifier_node'
require 'rubbycop/cop/mixin/annotation_comment'
require 'rubbycop/cop/mixin/array_hash_indentation'
require 'rubbycop/cop/mixin/array_min_size'
require 'rubbycop/cop/mixin/array_syntax'
require 'rubbycop/cop/mixin/autocorrect_alignment'
require 'rubbycop/cop/mixin/check_assignment'
require 'rubbycop/cop/mixin/configurable_max'
require 'rubbycop/cop/mixin/code_length' # relies on configurable_max
require 'rubbycop/cop/mixin/classish_length' # relies on code_length
require 'rubbycop/cop/mixin/configurable_enforced_style'
require 'rubbycop/cop/mixin/configurable_formatting'
require 'rubbycop/cop/mixin/configurable_naming'
require 'rubbycop/cop/mixin/configurable_numbering'
require 'rubbycop/cop/mixin/def_node'
require 'rubbycop/cop/mixin/documentation_comment'
require 'rubbycop/cop/mixin/duplication'
require 'rubbycop/cop/mixin/empty_lines_around_body'
require 'rubbycop/cop/mixin/end_keyword_alignment'
require 'rubbycop/cop/mixin/enforce_superclass'
require 'rubbycop/cop/mixin/first_element_line_break'
require 'rubbycop/cop/mixin/frozen_string_literal'
require 'rubbycop/cop/mixin/hash_alignment'
require 'rubbycop/cop/mixin/ignored_pattern'
require 'rubbycop/cop/mixin/integer_node'
require 'rubbycop/cop/mixin/on_method_def'
require 'rubbycop/cop/mixin/match_range'
require 'rubbycop/cop/mixin/method_complexity' # relies on on_method_def
require 'rubbycop/cop/mixin/method_preference'
require 'rubbycop/cop/mixin/min_body_length'
require 'rubbycop/cop/mixin/multiline_expression_indentation'
require 'rubbycop/cop/mixin/multiline_literal_brace_layout'
require 'rubbycop/cop/mixin/negative_conditional'
require 'rubbycop/cop/mixin/on_normal_if_unless'
require 'rubbycop/cop/mixin/parentheses'
require 'rubbycop/cop/mixin/parser_diagnostic'
require 'rubbycop/cop/mixin/percent_literal'
require 'rubbycop/cop/mixin/preceding_following_alignment'
require 'rubbycop/cop/mixin/rescue_node'
require 'rubbycop/cop/mixin/safe_assignment'
require 'rubbycop/cop/mixin/safe_mode'
require 'rubbycop/cop/mixin/space_after_punctuation'
require 'rubbycop/cop/mixin/space_before_punctuation'
require 'rubbycop/cop/mixin/surrounding_space'
require 'rubbycop/cop/mixin/space_inside' # relies on surrounding_space
require 'rubbycop/cop/mixin/statement_modifier'
require 'rubbycop/cop/mixin/string_help'
require 'rubbycop/cop/mixin/string_literals_help'
require 'rubbycop/cop/mixin/target_ruby_version'
require 'rubbycop/cop/mixin/target_rails_version'
require 'rubbycop/cop/mixin/too_many_lines'
require 'rubbycop/cop/mixin/trailing_comma'
require 'rubbycop/cop/mixin/unused_argument'

require 'rubbycop/cop/bundler/duplicated_gem'
require 'rubbycop/cop/bundler/ordered_gems'

require 'rubbycop/cop/layout/access_modifier_indentation'
require 'rubbycop/cop/layout/align_array'
require 'rubbycop/cop/layout/align_hash'
require 'rubbycop/cop/layout/align_parameters'
require 'rubbycop/cop/layout/block_end_newline'
require 'rubbycop/cop/layout/case_indentation'
require 'rubbycop/cop/layout/closing_parenthesis_indentation'
require 'rubbycop/cop/layout/comment_indentation'
require 'rubbycop/cop/layout/dot_position'
require 'rubbycop/cop/layout/else_alignment'
require 'rubbycop/cop/layout/empty_line_after_magic_comment'
require 'rubbycop/cop/layout/empty_line_between_defs'
require 'rubbycop/cop/layout/empty_lines_around_access_modifier'
require 'rubbycop/cop/layout/empty_lines_around_begin_body'
require 'rubbycop/cop/layout/empty_lines_around_block_body'
require 'rubbycop/cop/layout/empty_lines_around_class_body'
require 'rubbycop/cop/layout/empty_lines_around_exception_handling_keywords'
require 'rubbycop/cop/layout/empty_lines_around_method_body'
require 'rubbycop/cop/layout/empty_lines_around_module_body'
require 'rubbycop/cop/layout/empty_lines'
require 'rubbycop/cop/layout/end_of_line'
require 'rubbycop/cop/layout/extra_spacing'
require 'rubbycop/cop/layout/first_array_element_line_break'
require 'rubbycop/cop/layout/first_hash_element_line_break'
require 'rubbycop/cop/layout/first_method_argument_line_break'
require 'rubbycop/cop/layout/first_method_parameter_line_break'
require 'rubbycop/cop/layout/first_parameter_indentation'
require 'rubbycop/cop/layout/indent_array'
require 'rubbycop/cop/layout/indent_assignment'
require 'rubbycop/cop/layout/indentation_consistency'
require 'rubbycop/cop/layout/indentation_width'
require 'rubbycop/cop/layout/indent_hash'
require 'rubbycop/cop/layout/indent_heredoc'
require 'rubbycop/cop/layout/initial_indentation'
require 'rubbycop/cop/layout/leading_comment_space'
require 'rubbycop/cop/layout/multiline_array_brace_layout'
require 'rubbycop/cop/layout/multiline_assignment_layout'
require 'rubbycop/cop/layout/multiline_block_layout'
require 'rubbycop/cop/layout/multiline_hash_brace_layout'
require 'rubbycop/cop/layout/multiline_method_call_brace_layout'
require 'rubbycop/cop/layout/multiline_method_call_indentation'
require 'rubbycop/cop/layout/multiline_method_definition_brace_layout'
require 'rubbycop/cop/layout/multiline_operation_indentation'
require 'rubbycop/cop/layout/rescue_ensure_alignment'
require 'rubbycop/cop/layout/space_after_colon'
require 'rubbycop/cop/layout/space_after_comma'
require 'rubbycop/cop/layout/space_after_method_name'
require 'rubbycop/cop/layout/space_after_not'
require 'rubbycop/cop/layout/space_after_semicolon'
require 'rubbycop/cop/layout/space_around_block_parameters'
require 'rubbycop/cop/layout/space_around_equals_in_parameter_default'
require 'rubbycop/cop/layout/space_around_keyword'
require 'rubbycop/cop/layout/space_around_operators'
require 'rubbycop/cop/layout/space_before_block_braces'
require 'rubbycop/cop/layout/space_before_comma'
require 'rubbycop/cop/layout/space_before_comment'
require 'rubbycop/cop/layout/space_before_first_arg'
require 'rubbycop/cop/layout/space_before_semicolon'
require 'rubbycop/cop/layout/space_in_lambda_literal'
require 'rubbycop/cop/layout/space_inside_array_percent_literal'
require 'rubbycop/cop/layout/space_inside_block_braces'
require 'rubbycop/cop/layout/space_inside_brackets'
require 'rubbycop/cop/layout/space_inside_hash_literal_braces'
require 'rubbycop/cop/layout/space_inside_parens'
require 'rubbycop/cop/layout/space_inside_percent_literal_delimiters'
require 'rubbycop/cop/layout/space_inside_range_literal'
require 'rubbycop/cop/layout/space_inside_string_interpolation'
require 'rubbycop/cop/layout/tab'
require 'rubbycop/cop/layout/trailing_blank_lines'
require 'rubbycop/cop/layout/trailing_whitespace'

require 'rubbycop/cop/lint/ambiguous_block_association'
require 'rubbycop/cop/lint/ambiguous_operator'
require 'rubbycop/cop/lint/ambiguous_regexp_literal'
require 'rubbycop/cop/lint/assignment_in_condition'
require 'rubbycop/cop/lint/block_alignment'
require 'rubbycop/cop/lint/circular_argument_reference'
require 'rubbycop/cop/lint/condition_position'
require 'rubbycop/cop/lint/debugger'
require 'rubbycop/cop/lint/def_end_alignment'
require 'rubbycop/cop/lint/deprecated_class_methods'
require 'rubbycop/cop/lint/duplicate_case_condition'
require 'rubbycop/cop/lint/duplicate_methods'
require 'rubbycop/cop/lint/duplicated_key'
require 'rubbycop/cop/lint/each_with_object_argument'
require 'rubbycop/cop/lint/else_layout'
require 'rubbycop/cop/lint/empty_ensure'
require 'rubbycop/cop/lint/empty_expression'
require 'rubbycop/cop/lint/empty_interpolation'
require 'rubbycop/cop/lint/empty_when'
require 'rubbycop/cop/lint/end_alignment'
require 'rubbycop/cop/lint/end_in_method'
require 'rubbycop/cop/lint/ensure_return'
require 'rubbycop/cop/lint/float_out_of_range'
require 'rubbycop/cop/lint/format_parameter_mismatch'
require 'rubbycop/cop/lint/handle_exceptions'
require 'rubbycop/cop/lint/implicit_string_concatenation'
require 'rubbycop/cop/lint/inherit_exception'
require 'rubbycop/cop/lint/ineffective_access_modifier'
require 'rubbycop/cop/lint/invalid_character_literal'
require 'rubbycop/cop/lint/literal_in_condition'
require 'rubbycop/cop/lint/literal_in_interpolation'
require 'rubbycop/cop/lint/loop'
require 'rubbycop/cop/lint/multiple_compare'
require 'rubbycop/cop/lint/nested_method_definition'
require 'rubbycop/cop/lint/next_without_accumulator'
require 'rubbycop/cop/lint/non_local_exit_from_iterator'
require 'rubbycop/cop/lint/parentheses_as_grouped_expression'
require 'rubbycop/cop/lint/percent_string_array'
require 'rubbycop/cop/lint/percent_symbol_array'
require 'rubbycop/cop/lint/rand_one'
require 'rubbycop/cop/lint/require_parentheses'
require 'rubbycop/cop/lint/rescue_exception'
require 'rubbycop/cop/lint/safe_navigation_chain'
require 'rubbycop/cop/lint/shadowed_exception'
require 'rubbycop/cop/lint/shadowing_outer_local_variable'
require 'rubbycop/cop/lint/string_conversion_in_interpolation'
require 'rubbycop/cop/lint/syntax'
require 'rubbycop/cop/lint/underscore_prefixed_variable_name'
require 'rubbycop/cop/lint/unified_integer'
require 'rubbycop/cop/lint/unneeded_disable'
require 'rubbycop/cop/lint/unneeded_splat_expansion'
require 'rubbycop/cop/lint/unreachable_code'
require 'rubbycop/cop/lint/unused_block_argument'
require 'rubbycop/cop/lint/unused_method_argument'
require 'rubbycop/cop/lint/useless_access_modifier'
require 'rubbycop/cop/lint/useless_assignment'
require 'rubbycop/cop/lint/useless_comparison'
require 'rubbycop/cop/lint/useless_else_without_rescue'
require 'rubbycop/cop/lint/useless_setter_call'
require 'rubbycop/cop/lint/void'

require 'rubbycop/cop/metrics/cyclomatic_complexity'
require 'rubbycop/cop/metrics/abc_size' # relies on cyclomatic_complexity
require 'rubbycop/cop/metrics/block_length'
require 'rubbycop/cop/metrics/block_nesting'
require 'rubbycop/cop/metrics/class_length'
require 'rubbycop/cop/metrics/line_length'
require 'rubbycop/cop/metrics/method_length'
require 'rubbycop/cop/metrics/module_length'
require 'rubbycop/cop/metrics/parameter_lists'
require 'rubbycop/cop/metrics/perceived_complexity'

require 'rubbycop/cop/performance/caller'
require 'rubbycop/cop/performance/case_when_splat'
require 'rubbycop/cop/performance/casecmp'
require 'rubbycop/cop/performance/count'
require 'rubbycop/cop/performance/detect'
require 'rubbycop/cop/performance/double_start_end_with'
require 'rubbycop/cop/performance/end_with'
require 'rubbycop/cop/performance/fixed_size'
require 'rubbycop/cop/performance/flat_map'
require 'rubbycop/cop/performance/hash_each_methods'
require 'rubbycop/cop/performance/lstrip_rstrip'
require 'rubbycop/cop/performance/range_include'
require 'rubbycop/cop/performance/redundant_block_call'
require 'rubbycop/cop/performance/redundant_match'
require 'rubbycop/cop/performance/redundant_merge'
require 'rubbycop/cop/performance/redundant_sort_by'
require 'rubbycop/cop/performance/regexp_match'
require 'rubbycop/cop/performance/reverse_each'
require 'rubbycop/cop/performance/sample'
require 'rubbycop/cop/performance/size'
require 'rubbycop/cop/performance/compare_with_block'
require 'rubbycop/cop/performance/start_with'
require 'rubbycop/cop/performance/string_replacement'
require 'rubbycop/cop/performance/times_map'

require 'rubbycop/cop/style/accessor_method_name'
require 'rubbycop/cop/style/alias'
require 'rubbycop/cop/style/and_or'
require 'rubbycop/cop/style/array_join'
require 'rubbycop/cop/style/ascii_comments'
require 'rubbycop/cop/style/ascii_identifiers'
require 'rubbycop/cop/style/attr'
require 'rubbycop/cop/style/auto_resource_cleanup'
require 'rubbycop/cop/style/bare_percent_literals'
require 'rubbycop/cop/style/begin_block'
require 'rubbycop/cop/style/block_comments'
require 'rubbycop/cop/style/block_delimiters'
require 'rubbycop/cop/style/braces_around_hash_parameters'
require 'rubbycop/cop/style/case_equality'
require 'rubbycop/cop/style/character_literal'
require 'rubbycop/cop/style/class_and_module_camel_case'
require 'rubbycop/cop/style/class_and_module_children'
require 'rubbycop/cop/style/class_check'
require 'rubbycop/cop/style/class_methods'
require 'rubbycop/cop/style/class_vars'
require 'rubbycop/cop/style/collection_methods'
require 'rubbycop/cop/style/colon_method_call'
require 'rubbycop/cop/style/command_literal'
require 'rubbycop/cop/style/comment_annotation'
require 'rubbycop/cop/style/conditional_assignment'
require 'rubbycop/cop/style/constant_name'
require 'rubbycop/cop/style/copyright'
require 'rubbycop/cop/style/def_with_parentheses'
require 'rubbycop/cop/style/preferred_hash_methods'
require 'rubbycop/cop/style/documentation_method'
require 'rubbycop/cop/style/documentation'
require 'rubbycop/cop/style/double_negation'
require 'rubbycop/cop/style/each_for_simple_loop'
require 'rubbycop/cop/style/each_with_object'
require 'rubbycop/cop/style/empty_case_condition'
require 'rubbycop/cop/style/empty_else'
require 'rubbycop/cop/style/empty_literal'
require 'rubbycop/cop/style/empty_method'
require 'rubbycop/cop/style/encoding'
require 'rubbycop/cop/style/end_block'
require 'rubbycop/cop/style/even_odd'
require 'rubbycop/cop/style/file_name'
require 'rubbycop/cop/style/flip_flop'
require 'rubbycop/cop/style/for'
require 'rubbycop/cop/style/format_string'
require 'rubbycop/cop/style/format_string_token'
require 'rubbycop/cop/style/frozen_string_literal_comment'
require 'rubbycop/cop/style/global_vars'
require 'rubbycop/cop/style/guard_clause'
require 'rubbycop/cop/style/hash_syntax'
require 'rubbycop/cop/style/identical_conditional_branches'
require 'rubbycop/cop/style/if_inside_else'
require 'rubbycop/cop/style/if_unless_modifier'
require 'rubbycop/cop/style/if_unless_modifier_of_if_unless'
require 'rubbycop/cop/style/if_with_semicolon'
require 'rubbycop/cop/style/implicit_runtime_error'
require 'rubbycop/cop/style/infinite_loop'
require 'rubbycop/cop/style/inverse_methods'
require 'rubbycop/cop/style/inline_comment'
require 'rubbycop/cop/style/lambda'
require 'rubbycop/cop/style/lambda_call'
require 'rubbycop/cop/style/line_end_concatenation'
require 'rubbycop/cop/style/method_call_without_args_parentheses'
require 'rubbycop/cop/style/method_call_with_args_parentheses'
require 'rubbycop/cop/style/method_called_on_do_end_block'
require 'rubbycop/cop/style/method_def_parentheses'
require 'rubbycop/cop/style/method_name'
require 'rubbycop/cop/style/method_missing'
require 'rubbycop/cop/style/missing_else'
require 'rubbycop/cop/style/mixin_grouping'
require 'rubbycop/cop/style/module_function'
require 'rubbycop/cop/style/multiline_block_chain'
require 'rubbycop/cop/style/multiline_if_then'
require 'rubbycop/cop/style/multiline_if_modifier'
require 'rubbycop/cop/style/multiline_memoization'
require 'rubbycop/cop/style/multiline_ternary_operator'
require 'rubbycop/cop/style/mutable_constant'
require 'rubbycop/cop/style/negated_if'
require 'rubbycop/cop/style/negated_while'
require 'rubbycop/cop/style/nested_modifier'
require 'rubbycop/cop/style/nested_parenthesized_calls'
require 'rubbycop/cop/style/nested_ternary_operator'
require 'rubbycop/cop/style/next'
require 'rubbycop/cop/style/nil_comparison'
require 'rubbycop/cop/style/non_nil_check'
require 'rubbycop/cop/style/not'
require 'rubbycop/cop/style/numeric_literals'
require 'rubbycop/cop/style/numeric_literal_prefix'
require 'rubbycop/cop/style/numeric_predicate'
require 'rubbycop/cop/style/one_line_conditional'
require 'rubbycop/cop/style/op_method'
require 'rubbycop/cop/style/option_hash'
require 'rubbycop/cop/style/optional_arguments'
require 'rubbycop/cop/style/parallel_assignment'
require 'rubbycop/cop/style/parentheses_around_condition'
require 'rubbycop/cop/style/percent_literal_delimiters'
require 'rubbycop/cop/style/percent_q_literals'
require 'rubbycop/cop/style/perl_backrefs'
require 'rubbycop/cop/style/predicate_name'
require 'rubbycop/cop/style/proc'
require 'rubbycop/cop/style/raise_args'
require 'rubbycop/cop/style/redundant_begin'
require 'rubbycop/cop/style/redundant_exception'
require 'rubbycop/cop/style/redundant_freeze'
require 'rubbycop/cop/style/redundant_parentheses'
require 'rubbycop/cop/style/redundant_return'
require 'rubbycop/cop/style/redundant_self'
require 'rubbycop/cop/style/regexp_literal'
require 'rubbycop/cop/style/rescue_modifier'
require 'rubbycop/cop/style/safe_navigation'
require 'rubbycop/cop/style/self_assignment'
require 'rubbycop/cop/style/semicolon'
require 'rubbycop/cop/style/send'
require 'rubbycop/cop/style/signal_exception'
require 'rubbycop/cop/style/single_line_block_params'
require 'rubbycop/cop/style/single_line_methods'
require 'rubbycop/cop/style/special_global_vars'
require 'rubbycop/cop/style/stabby_lambda_parentheses'
require 'rubbycop/cop/style/string_literals'
require 'rubbycop/cop/style/string_literals_in_interpolation'
require 'rubbycop/cop/style/string_methods'
require 'rubbycop/cop/style/struct_inheritance'
require 'rubbycop/cop/style/symbol_array'
require 'rubbycop/cop/style/symbol_literal'
require 'rubbycop/cop/style/symbol_proc'
require 'rubbycop/cop/style/ternary_parentheses'
require 'rubbycop/cop/style/trailing_comma_in_arguments'
require 'rubbycop/cop/style/trailing_comma_in_literal'
require 'rubbycop/cop/style/trailing_underscore_variable'
require 'rubbycop/cop/style/trivial_accessors'
require 'rubbycop/cop/style/unless_else'
require 'rubbycop/cop/style/unneeded_capital_w'
require 'rubbycop/cop/style/unneeded_interpolation'
require 'rubbycop/cop/style/unneeded_percent_q'
require 'rubbycop/cop/style/variable_interpolation'
require 'rubbycop/cop/style/variable_name'
require 'rubbycop/cop/style/variable_number'
require 'rubbycop/cop/style/when_then'
require 'rubbycop/cop/style/while_until_do'
require 'rubbycop/cop/style/while_until_modifier'
require 'rubbycop/cop/style/word_array'
require 'rubbycop/cop/style/zero_length_predicate'

require 'rubbycop/cop/rails/action_filter'
require 'rubbycop/cop/rails/active_support_aliases'
require 'rubbycop/cop/rails/application_job'
require 'rubbycop/cop/rails/application_record'
require 'rubbycop/cop/rails/blank'
require 'rubbycop/cop/rails/date'
require 'rubbycop/cop/rails/dynamic_find_by'
require 'rubbycop/cop/rails/delegate'
require 'rubbycop/cop/rails/delegate_allow_blank'
require 'rubbycop/cop/rails/enum_uniqueness'
require 'rubbycop/cop/rails/exit'
require 'rubbycop/cop/rails/file_path'
require 'rubbycop/cop/rails/find_by'
require 'rubbycop/cop/rails/find_each'
require 'rubbycop/cop/rails/has_and_belongs_to_many'
require 'rubbycop/cop/rails/http_positional_arguments'
require 'rubbycop/cop/rails/not_null_column'
require 'rubbycop/cop/rails/output_safety'
require 'rubbycop/cop/rails/output'
require 'rubbycop/cop/rails/pluralization_grammar'
require 'rubbycop/cop/rails/present'
require 'rubbycop/cop/rails/read_write_attribute'
require 'rubbycop/cop/rails/request_referer'
require 'rubbycop/cop/rails/reversible_migration'
require 'rubbycop/cop/rails/relative_date_constant'
require 'rubbycop/cop/rails/safe_navigation'
require 'rubbycop/cop/rails/save_bang'
require 'rubbycop/cop/rails/scope_args'
require 'rubbycop/cop/rails/skips_model_validations'
require 'rubbycop/cop/rails/time_zone'
require 'rubbycop/cop/rails/uniq_before_pluck'
require 'rubbycop/cop/rails/validation'

require 'rubbycop/cop/security/eval'
require 'rubbycop/cop/security/json_load'
require 'rubbycop/cop/security/marshal_load'
require 'rubbycop/cop/security/yaml_load'

require 'rubbycop/cop/team'

require 'rubbycop/formatter/base_formatter'
require 'rubbycop/formatter/simple_text_formatter'
require 'rubbycop/formatter/clang_style_formatter' # relies on simple text
require 'rubbycop/formatter/disabled_config_formatter'
require 'rubbycop/formatter/disabled_lines_formatter'
require 'rubbycop/formatter/emacs_style_formatter'
require 'rubbycop/formatter/file_list_formatter'
require 'rubbycop/formatter/fuubar_style_formatter'
require 'rubbycop/formatter/html_formatter'
require 'rubbycop/formatter/json_formatter'
require 'rubbycop/formatter/offense_count_formatter'
require 'rubbycop/formatter/progress_formatter'
require 'rubbycop/formatter/worst_offenders_formatter'

require 'rubbycop/formatter/formatter_set'

require 'rubbycop/cached_data'
require 'rubbycop/config'
require 'rubbycop/config_loader_resolver'
require 'rubbycop/config_loader'
require 'rubbycop/config_store'
require 'rubbycop/target_finder'
require 'rubbycop/token'
require 'rubbycop/comment_config'
require 'rubbycop/magic_comment'
require 'rubbycop/processed_source'
require 'rubbycop/result_cache'
require 'rubbycop/runner'
require 'rubbycop/cli'
require 'rubbycop/options'
require 'rubbycop/remote_config'