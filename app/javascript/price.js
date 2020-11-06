function price () {
  const input = document.getElementById("item-price");
  input.addEventListener("input", () => {
    const value = input.value;
    const tax = document.getElementById("add-tax-price");
    tax.innerHTML = Math.floor(value * 0.1);
    const profit = document.getElementById("profit");
    profit.innerHTML = Math.floor(value - value * 0.1);
  }) 
}

window.addEventListener('load', price);

