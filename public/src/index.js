

const form = document.querySelector('form');
form.addEventListener('submit', async event=>{
    event.preventDefault();
    const formData = new FormData(form);

    try{
        const response = await fetch('../index.php',{
            method:'POST',
            body:formData
        });
    
        console.log(Object.fromEntries(formData));
        const jsonResponse = await response.json();
        console.log(jsonResponse);
        if(jsonResponse.message){
            alert(jsonResponse.message);
            setTimeout(()=>{
                window.location.reload();
            },2000);
        }
    }catch(err){
        console.error(err);
    }

});


window.addEventListener('load', async()=>{
    try{
        const response = await fetch('../index.php');
        const jsonResponse = await response.json();
        
        const tbody = document.querySelector('tbody');
        if(jsonResponse.success == false){
            document.body.innerHTML = `<h1 style="text-align:center; margin-top:20%;">${jsonResponse.message}</h1>`;   
        }
        else{
            tbody.innerHTML = ``;
            jsonResponse.forEach(element=>{
                tbody.innerHTML += `
                                <tr>
                                    <td>${element.nome}</td>
                                    <td>${element.municipio}</td>
                                    <td>${element.categoria}</td>
                                    <td>${element.clube}</td>
                                    <td>${element.clube_municipio}</td>
                                    <td>${element.data_nascimento}</td>
                                </tr>
                                `;
            });
        }
    }catch(err){
        console.error(err);
    }
});