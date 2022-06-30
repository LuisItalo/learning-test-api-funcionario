Dado('que o usuario consulte informacoes de funcionario') do
    @get_url = 'http://dummy.restapiexample.com/api/v1/employees'
  end
  
  Quando('ele realizar a pesquisa') do
    @list_employee = HTTParty.get(@get_url)
  end
  
  Entao('uma lista de funcionarios deve retornar') do
    expect(@list_employee.code).to eql 200
    expect(@list_employee.message).to eql 'OK'
  end

  Dado('que o usuario cadastr um novo funcionario') do
      @post_url = 'http://dummy.restapiexample.com/api/v1/create'
  end
  
  Quando('ele enviar informacoes do funcionario') do
      @create_employee = HTTParty.post(@post_url, :headers => {'Content-Type': 'application/json'}, body: {
        "id": 34,
        "employee_name": "Italo",
        "employee_salary": 234344,
        "employee_age": 31,
        "profile_image": ""
      }.to_json)

      puts @create_employee
  end
  
  Entao('esse funcionario sera cadastrado') do
    expect(@create_employee.code).to eql (200)
    expect(@create_employee.msg).to eql 'OK'
    expect(@create_employee["status"]).to eql 'success'
    expect(@create_employee["message"]).to eql 'Successfully! Record has been added.'
    expect(@create_employee['data']["employee_name"]).to eql 'Italo' 
    #utilizar caso api nao retorne string
    #puts @create_employee.parserd_response
  end

  Dado('que o usuario altere uma informacao de funcionario') do
    @get_employee =  HTTParty.get('http://dummy.restapiexample.com/api/v1/employees', :headers => {'Content-Type': 'application/jason'})
    puts @get_employee['data'][0]['id']
    @put_url = 'http://dummy.restapiexample.com/api/v1/update/' + @get_employee['data'][0]['id'].to_s
  end
  
  Quando('ele enviar as novas informacoes') do
    @update_employee = HTTParty.put(@put_url, :headers => {'Content-Type': 'application/json'}, body: {
      "employee_name": "credo",
      "employee_salary": 100,
      "employee_age": 23,
      "profile_image": ""
    }.to_json)
  end
  
  Entao('as informacoes serao alteradas') do
    expect(@update_employee.code).to eql (200)
    expect(@update_employee.msg).to eql 'OK'
    expect(@update_employee["status"]).to eql 'success'
    expect(@update_employee["message"]).to eql 'Successfully! Record has been updated.'
    expect(@update_employee["data"]["employee_name"]).to eql 'credo'
  end

  Dado('que o usuario queira deletar um funcionario') do
    @delete_url = 'http://dummy.restapiexample.com/api/v1/delete/2'
  end
  
  Quando('ele enviar a identificacao unica') do
    @delete_employee = HTTParty.delete(@delete_url, :headers => {'Content-Type': 'application/json'})
  end
  
  Entao('esse funcionario sera deletado do sistema') do
    expect(@delete_employee.code).to eql (200)
    expect(@delete_employee.msg).to eql 'OK'
    expect(@delete_employee["status"]).to eql 'success'
    expect(@delete_employee["data"]).to eql '2'
    expect(@delete_employee["message"]).to eql 'Successfully! Record has been deleted'
  end