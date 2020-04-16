function validate(){
  var username = document.getElementById("uname");
  var password = document.getElementById("pass");

  if(username.value == "" || password.value == "")
  {
    alert("Enter a Username and a Password");
    return false;
  }
  else
  {
    return true;
  }
}