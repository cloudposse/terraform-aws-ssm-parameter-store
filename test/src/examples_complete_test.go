package test

import (
	"strings"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	t.Parallel()

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	output := terraform.Output(t, terraformOptions, "map")

	key1_result := strings.Contains(output, "/production/test/master/company")
	value1_result := strings.Contains(output, "Amazon")
	key2_result := strings.Contains(output, "/production/test/master/users")
	value2_result := strings.Contains(output, "John,Todd")

	// Verify we're getting back the outputs we expect
	assert.True(t, key1_result, "The 'map' output should have the master/company key")
	assert.True(t, value1_result, "The master/company key's value should be 'Amazon'")

	assert.True(t, key2_result, "The 'map' output should have the master/users key")
	assert.True(t, value2_result, "The master/users key's value should be 'John,Todd'")
}
