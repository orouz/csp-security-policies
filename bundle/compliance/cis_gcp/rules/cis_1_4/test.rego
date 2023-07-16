package compliance.cis_gcp.rules.cis_1_4

import data.cis_gcp.test_data
import data.compliance.lib.common
import data.compliance.policy.gcp.data_adapter
import data.lib.test

test_violation {
	eval_fail with input as test_data.generate_iam_policy(["user:foo"], "role")
}

test_pass {
	eval_pass with input as test_data.generate_iam_policy(["foo"], "role")
}

test_not_evaluated {
	not_eval with input as test_data.not_eval_resource
}

eval_fail {
	test.assert_fail(finding) with data.benchmark_data_adapter as data_adapter
}

eval_pass {
	test.assert_pass(finding) with data.benchmark_data_adapter as data_adapter
}

not_eval {
	not finding with data.benchmark_data_adapter as data_adapter
}
