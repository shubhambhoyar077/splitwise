document.addEventListener('turbolinks:load', function () {
  function expenseForm() {
    let equalCheckbox = document.getElementById('equal-checkbox');
    let fixedCheckbox = document.getElementById('fixed-checkbox');

    equalCheckbox.addEventListener('change', function () {
      fixedCheckbox.checked = !equalCheckbox.checked;
      var dynamicAmountInputs = document.querySelectorAll('.split-amount');
      dynamicAmountInputs.forEach(function (dynamicAmountInput) {
        dynamicAmountInput.readonly = true;
      });
    });

    fixedCheckbox.addEventListener('change', function () {
      equalCheckbox.checked = !fixedCheckbox.checked;
      var dynamicAmountInputs = document.querySelectorAll('.split-amount');
      dynamicAmountInputs.forEach(function (dynamicAmountInput) {
        dynamicAmountInput.readonly = false;
      });
    });

    var totalAmountInput = document.getElementById('total-amount');
    let totalAmountValue = 0;

    totalAmountInput.addEventListener('input', function () {
      // Read the total_amount value when it changes
      totalAmountValue = parseFloat(totalAmountInput.value);
      console.log('Total Amount changed to:', totalAmountValue);
      var dynamicAmountInputs = document.querySelectorAll('.split-amount');
      if (isNaN(totalAmountValue)) {
        totalAmountValue = 0;
      }

      dynamicAmountInputs.forEach(function (dynamicAmountInput) {
        dynamicAmountInput.value =
          totalAmountValue / dynamicAmountInputs.length;
      });
    });
  }
  console.log('working');
  expenseForm();
});
