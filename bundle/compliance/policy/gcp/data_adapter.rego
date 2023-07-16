package compliance.policy.gcp.data_adapter

resource = input.resource.resource

iam_policy = input.resource.iam_policy

is_gcs_bucket {
	input.subType == "gcp-gcs"
}

is_iam {
	input.subType == "gcp-iam"
}

is_kms_key {
	input.subType == "gcp-kms"
}

is_bq_dataset {
	input.subType == "gcp-bq-dataset"
}

is_bq_table {
	input.subType == "gcp-bq-table"
}
