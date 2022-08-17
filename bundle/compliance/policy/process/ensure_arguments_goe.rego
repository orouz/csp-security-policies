package compliance.policy.process.ensure_arguments_goe

import data.compliance.lib.common as lib_common
import data.compliance.policy.process.common as process_common
import data.compliance.policy.process.data_adapter

finding(entity, value) = result {
	data_adapter.is_kube_apiserver

	# set result
	result := lib_common.generate_result_without_expected(
		lib_common.calculate_result(rule_evaluation(entity, value)),
		{"process_args": data_adapter.process_args},
	)
}

rule_evaluation(entity, value) {
	e := data_adapter.process_args[entity]
	process_common.greater_or_equal(e, value)
} else = false {
	true
}