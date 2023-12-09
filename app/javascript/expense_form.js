document.addEventListener('turbolinks:load', function () {
  function expenseForm() {
    let equalCheckbox = document.getElementById('equal-checkbox');
    let fixedCheckbox = document.getElementById('fixed-checkbox');
    var totalAmountInput = document.getElementById('total-amount');
    let totalAmountValue = 0;

    equalCheckbox.checked = true;

    function updateDynamicAmountInputs() {
      let dynamicAmountInputs = document.querySelectorAll('.split-amount');
      dynamicAmountInputs.forEach(function (dynamicAmountInput) {
        if (equalCheckbox.checked) {
          dynamicAmountInput.setAttribute('readonly', true);
          dynamicAmountInput.value =
            totalAmountValue / dynamicAmountInputs.length;
        } else {
          dynamicAmountInput.removeAttribute('readonly');
        }
      });
    }

    equalCheckbox.addEventListener('change', function () {
      fixedCheckbox.checked = !equalCheckbox.checked;
      updateDynamicAmountInputs();
    });

    fixedCheckbox.addEventListener('change', function () {
      equalCheckbox.checked = !fixedCheckbox.checked;
      updateDynamicAmountInputs();
    });

    totalAmountInput.addEventListener('input', function () {
      totalAmountValue = parseFloat(totalAmountInput.value) || 0;
      updateDynamicAmountInputs();
    });
  }
  expenseForm();
});
