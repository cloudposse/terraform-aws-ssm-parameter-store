package test

import (
	"fmt"
	"math/rand"
	"strconv"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

const preExistingKeyFormat = "/production/test/master/preexisting_key_%s"

// Test the Terraform module in examples/complete using Terratest.
func TestExamplesComplete(t *testing.T) {
	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
	}

	terraform.Init(t, terraformOptions)
	// Run tests in parallel
	t.Run("Disabled", testExamplesCompleteDisabled)
	t.Run("Enabled", testExamplesCompleteEnabled)
}

func testExamplesCompleteDisabled(t *testing.T) {
	t.Parallel()

	attributes := []string{strconv.Itoa(rand.Intn(100000))}
	preExistingKeyName := fmt.Sprintf(preExistingKeyFormat, attributes[0])

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		EnvVars: map[string]string{
			"TF_CLI_ARGS": "-state=terraform-disabled-test.tfstate",
		},
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
		Vars: map[string]interface{}{
			"enabled": false,
			"attributes": attributes,
			"parameter_read": []string{
				preExistingKeyName,
			},
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform apply` and fail the test if there are any errors
	terraform.Apply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	output := terraform.OutputMap(t, terraformOptions, "map")
	assert.Equal(t, len(output), 0, "There should be no outputs when the module is disabled.")
}

func testExamplesCompleteEnabled(t *testing.T) {
	t.Parallel()

	rand.Seed(time.Now().UnixNano() + 1) // give a slightly different seed than the other parallel test
	attributes := []string{strconv.Itoa(rand.Intn(100000))}
	preExistingKeyName := fmt.Sprintf(preExistingKeyFormat, attributes[0])

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: "../../examples/complete",
		Upgrade:      true,
		EnvVars: map[string]string{
			"TF_CLI_ARGS": "-state=terraform-enabled-test.tfstate",
		},
		// Variables to pass to our Terraform code using -var-file options
		VarFiles: []string{"fixtures.us-east-2.tfvars"},
		Vars: map[string]interface{}{
			"attributes": attributes,
			"parameter_read": []string{
				preExistingKeyName,
			},
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform apply` and fail the test if there are any errors
	terraform.Apply(t, terraformOptions)

	// Run `terraform output` to get the value of an output variable
	output := terraform.OutputMap(t, terraformOptions, "map")

	// Expected values for created parameters
	key1 := "/production/test/master/company"
	value1 := "Amazon"
	key2 := "/production/test/master/users"
	value2 := "John,Todd"

	// Expected values for preexisting parameters
	key3 := preExistingKeyName
	value3 := "preexisting_value"

	// Verify we're getting back the outputs we expect
	containsErrorMessageFormat := "The 'map' output should contain the %s key"
	equalsErrorMessageFormat := "The %s's value should be '%s'"

	assert.Contains(t, output, key1, fmt.Sprintf(containsErrorMessageFormat, key1))
	assert.Equal(t, value1 ,output[key1], fmt.Sprintf(equalsErrorMessageFormat, key1, value1))

	assert.Contains(t, output, key2, fmt.Sprintf(containsErrorMessageFormat, key2))
	assert.Equal(t, value2 ,output[key2], fmt.Sprintf(equalsErrorMessageFormat, key2, value2))

	assert.Contains(t, output, key3, fmt.Sprintf(containsErrorMessageFormat, key3))
	assert.Equal(t, value3 ,output[key3], fmt.Sprintf(equalsErrorMessageFormat, key3, value3))
}
