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
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	output := terraform.Output(t, terraformOptions, "map")

	key1Result := strings.Contains(output, "/production/test/master/company")
	value1Result := strings.Contains(output, "Amazon")
	key2Result := strings.Contains(output, "/production/test/master/users")
	value2Result := strings.Contains(output, "John,Todd")

	// Verify we're getting back the outputs we expect
	assert.True(t, key1Result, "The 'map' output should contain the /production/test/master/company key")
	assert.True(t, value1Result, "The /production/test/master/company key's value should be 'Amazon'")

	assert.True(t, key2Result, "The 'map' output should contain the /production/test/master/users key")
	assert.True(t, value2Result, "The /production/test/master/users key's value should be 'John,Todd'")
}
