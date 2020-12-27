document.addEventListener('DOMContentLoaded', function(){
    var buttonElement = document.getElementById('leftclick');
    buttonElement.addEventListener('click',function(event){
        console.log('An event triggerd: ' + event.type);
    });
});