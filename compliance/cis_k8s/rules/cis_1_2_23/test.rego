package compliance.cis_k8s.rules.cis_1_2_23

import data.cis_k8s.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as rule_input("api_server", "")
	test.assert_fail(finding) with input as rule_input("api_server", "--audit-log-maxage=29")
}

test_pass {
	test.assert_pass(finding) with input as rule_input("api_server", "--audit-log-maxage=30")
	test.assert_pass(finding) with input as rule_input("api_server", "--audit-log-maxage=60")
}

test_not_evaluated {
	not finding with input as rule_input("some_process", "")
}

rule_input(process_type, argument) = test_data.api_server_input(process_type, [argument])
