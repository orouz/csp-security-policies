package compliance.cis_eks.rules.cis_2_1_1

import data.cis_eks.test_data
import data.lib.test

test_violation {
	test.assert_fail(finding) with input as violating_input_all_logs_disabled
	test.assert_fail(finding) with input as violating_input_some_disabled
}

test_pass {
	test.assert_pass(finding) with input as non_violating_input
	test.assert_pass(finding) with input as non_violating_input
}

test_not_evaluated {
	not finding with input as not_evaluated_input
}

violating_input_all_logs_disabled = {
	"type": "aws-eks",
	"resource": {"Cluster": {
		"Arn": "arn:aws:somearn1234:cluster/EKS-demo",
		"CertificateAuthority": {"Data": "some data"},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"EncryptionConfig": null,
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBdDB096B80AA626B023SS520SS"}},
		"Logging": {"ClusterLogging": [{
			"Enabled": false,
			"Types": [
				"api",
				"audit",
				"authenticator",
				"controllerManager",
				"scheduler",
			],
		}]},
		"Name": "EKS-Elastic-agent-demo",
	}},
}

violating_input_some_disabled = {
	"type": "aws-eks",
	"resource": {"Cluster": {
		"Arn": "arn:aws:somearn1234:cluster/EKS-demo",
		"CertificateAuthority": {"Data": "some data"},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"EncryptionConfig": null,
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBdDB096B80AA626B023SS520SS"}},
		"Logging": {"ClusterLogging": [
			{
				"Enabled": false,
				"Types": [
					"authenticator",
					"controllerManager",
					"scheduler",
				],
			},
			{
				"Enabled": true,
				"Types": [
					"api",
					"audit",
				],
			},
		]},
		"Name": "EKS-Elastic-agent-demo",
	}},
}

non_violating_input = {
	"type": "aws-eks",
	"resource": {"Cluster": {
		"Arn": "arn:aws:somearn1234:cluster/EKS-demo",
		"CertificateAuthority": {"Data": "some data"},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"EncryptionConfig": null,
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBdDB096B80AA626B023SS520SS"}},
		"Logging": {"ClusterLogging": [{
			"Enabled": true,
			"Types": [
				"api",
				"audit",
				"authenticator",
				"controllerManager",
				"scheduler",
			],
		}]},
		"Name": "EKS-Elastic-agent-demo",
	}},
}

non_violating_input_wrong_structre = {
	"type": "aws-eks",
	"resource": {"Cluster": {
		"Arn": "arn:aws:somearn1234:cluster/EKS-demo",
		"CertificateAuthority": {"Data": "some data"},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"EncryptionConfig": null,
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBdDB096B80AA626B023SS520SS"}},
		"Logging": {"WrongField": [{
			"Enabled": true,
			"Types": [
				"api",
				"audit",
				"authenticator",
				"controllerManager",
				"scheduler",
			],
		}]},
		"Name": "EKS-Elastic-agent-demo",
	}},
}

not_evaluated_input = {
	"type": "some-type",
	"resource": {"Cluster": {
		"Arn": "arn:aws:somearn1234:cluster/EKS-demo",
		"CertificateAuthority": {"Data": "some data"},
		"ClientRequestToken": null,
		"CreatedAt": "2021-10-27T11:08:51Z",
		"EncryptionConfig": null,
		"Endpoint": "https://C07EBEDB096B808626B023DDBF7520DC.gr7.us-east-2.eks.amazonaws.com",
		"Identity": {"Oidc": {"Issuer": "https://oidc.eks.us-east-2.amazonaws.com/id/C07EBdDB096B80AA626B023SS520SS"}},
		"Logging": {"ClusterLogging": [{
			"Enabled": true,
			"Types": [
				"api",
				"audit",
				"authenticator",
				"controllerManager",
				"scheduler",
			],
		}]},
		"Name": "EKS-Elastic-agent-demo",
	}},
}
