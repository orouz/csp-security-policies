package compliance.cis_gcp.rules.cis_1_5

import data.cis_gcp.test_data
import data.compliance.policy.gcp.data_adapter
import data.lib.test

test_violation {
	eval_fail with input as test_data.generate_gcp_asset(
		"key-management",
		"gcp-cloudresourcemanager-project",
		{},
		{"bindings": [
			{
				"role": "roles/iam.workloadIdentityUser", # pass
				"members": ["serviceAccount:some-service@foo.iam.gserviceaccount.com"],
			},
			{
				"role": "roles/editor", # fail
				"members": ["serviceAccount:some-service@foo.iam.gserviceaccount.com"],
			},
		]},
	)

	eval_fail with input as test_data.generate_gcp_asset(
		"key-management",
		"gcp-cloudresourcemanager-project",
		{},
		{"bindings": [
			{
				"role": "roles/iam.workloadIdentityUser", # pass
				"members": ["serviceAccount:some-service@foo.iam.gserviceaccount.com"],
			},
			{
				"role": "roles/owner", # fail
				"members": ["serviceAccount:some-service@foo.iam.gserviceaccount.com"],
			},
		]},
	)
	eval_fail with input as test_data.generate_gcp_asset(
		"key-management",
		"gcp-cloudresourcemanager-project",
		{},
		{"bindings": [
			{
				"role": "roles/iam.workloadIdentityUser", # pass
				"members": ["serviceAccount:some-service@foo.iam.gserviceaccount.com"],
			},
			{
				"role": "roles/resourcemanager.projectIamAdmin", # fail
				"members": ["serviceAccount:some-service@foo.iam.gserviceaccount.com"],
			},
		]},
	)
}

test_pass {
	eval_pass with input as test_data.generate_gcp_asset(
		"key-management",
		"gcp-cloudresourcemanager-project",
		{},
		{"bindings": [{
			"role": "roles/iam.workloadIdentityUser", # pass
			"members": ["serviceAccount:some-service@foo.iam.gserviceaccount.com"],
		}]},
	)
}

test_not_evaluated {
	not_eval with input as test_data.not_eval_resource
	not_eval with input as test_data.no_policy_resource

	# ignores user and group accounts 
	not_eval with input as test_data.generate_gcp_asset(
		"key-management",
		"gcp-cloudresourcemanager-project",
		{},
		{"bindings": [
			{
				"role": "roles/iam.workloadIdentityUser",
				"members": ["user:some_user@foo.com"],
			},
			{
				"role": "roles/iam.workloadIdentityUser",
				"members": ["group:some_grouo@foo.com"],
			},
		]},
	)
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
