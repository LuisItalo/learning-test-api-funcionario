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