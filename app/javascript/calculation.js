function check(e) {
  if(document.URL.match(/new/) || document.URL.match(/edit/)) {
    const itemPrice = document.getElementById('item-price').value
    const addTaxPrice = document.getElementById("add-tax-price")
    const tax = `${itemPrice * 0.1}`
    addTaxPrice.textContent = tax
    
    const profit = document.getElementById("profit")
    const sales = `${itemPrice * 0.9}`
    profit.textContent = sales
    
    e.preventDefault();
  }
};
window.addEventListener('input', check);