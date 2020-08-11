function check(e) {
  const itemPrice = document.getElementById('item-price')
  const value = itemPrice.value
  const addTaxPrice = document.getElementById("add-tax-price")
  const tax = `${value * 0.1}`
  addTaxPrice.textContent = tax
  
  const profit = document.getElementById("profit")
  const sales = `${value * 0.9}`
  profit.textContent = sales
  
  e.preventDefault();
}
window.addEventListener('input', check);