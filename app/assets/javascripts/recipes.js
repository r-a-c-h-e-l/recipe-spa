document.addEventListener('DOMContentLoaded', function() {
  var addAllRecipes = function() {
    var xhr = new XMLHttpRequest();
    xhr.open('GET', 'http://localhost:3000/recipes.json');
    xhr.addEventListener('load', function() {
      var recipes = JSON.parse(xhr.responseText);
      console.log(recipes[0]);
      recipes.forEach(function(recipe) {
        addRecipe(recipe);
      });
    });
    xhr.send();
  }

  addAllRecipes(); //calling above function

  var deleteRecipe = function() {
    var li = this.parentNode;
    var id = li.id.substring(6);
    var xhr = new XMLHttpRequest();
    xhr.open('DELETE', 'http://localhost:3000/recipes/' + id);
    xhr.addEventListener('load', function() {
      if(JSON.parse(xhr.status === 200)) {
        li.remove();
      }
    });
    xhr.send();
  };


  var addRecipe = function(recipe) {
    //recipe name
    var h3 = document.createElement('h3');
    var name = recipe.name
    h3.innerHTML = name
    //recipe details
    var ul = document.createElement('ul');
    //ingredients
    var li1 = document.createElement('li');
    var ingredients = recipe.ingredients;
    li1.innerHTML = "Ingredients: " + ingredients;
    ul.appendChild(li1);
    //instructions
    var li2 = document.createElement('li');
    var instructions = recipe.instructions;
    li2.innerHTML = "Instructions: " + instructions;
    ul.appendChild(li2);
    var body = document.querySelector('body');
    //append all to body
    body.appendChild(h3);
    body.appendChild(ul);

  };

})
