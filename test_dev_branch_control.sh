#!/bin/bash

# Test script for dev_branch_control.sh

# Make sure the script is executable
chmod +x dev_branch_control.sh

echo "=== Testing dev_branch_control.sh ==="
echo ""

# Test help command
echo "Testing help command..."
./dev_branch_control.sh help
echo ""
echo "Help command test completed."
echo ""

# Test create-dev command
echo "Testing create-dev command..."
./dev_branch_control.sh create-dev
echo ""
echo "Create-dev command test completed."
echo ""

# Test status command
echo "Testing status command..."
./dev_branch_control.sh status
echo ""
echo "Status command test completed."
echo ""

# Test update-selector command
echo "Testing update-selector command..."
./dev_branch_control.sh update-selector
echo ""
echo "Update-selector command test completed."
echo ""

echo "=== All tests completed ==="
echo ""
echo "To use the development branch control script, run:"
echo "./dev_branch_control.sh [command]"
echo ""
echo "After creating an archive branch or updating the branch selector,"
echo "you can commit your changes with:"
echo "./dev_branch_control.sh commit \"Your commit message\""
echo ""
echo "To switch to the development branch, use:"
echo "./dev_branch_control.sh switch-dev"
echo ""
echo "To commit changes to the development branch, first switch to it,"
echo "then use the commit command:"
echo "./dev_branch_control.sh switch-dev"
echo "./dev_branch_control.sh commit \"Development changes\""
echo ""