user0 = User.create!(cpf: '004.566.086-72',
                     email: 'user@email.com',
                     password: '123456')
user1 = User.create!(cpf: '526.866.980-04',
                     email: 'analu_fernandes@compuativa.com.br',
                     password: '999999')
user2 = User.create!(cpf: '771.059.370-41',
                     email: 'evelyn_vieira@superacomunicacao.com.br',
                     password: '654321')
user3 = User.create!(cpf: '913.951.070-09',
                     email: 'thiago-pinto70@atualmarcenaria.com.br',
                     password: 'password')
user4 = User.create!(cpf: '243.089.080-19',
                     email: 'andre-daluz82@engenharia.ufjf.br',
                     password: '102030')
ash = FactoryBot.create(:user, email: 'ash@email.com')
brock = FactoryBot.create(:user, email: 'brock@email.com', cpf: '000.000.001-91')

FactoryBot.create(:project, user: ash)
pokemon_project = FactoryBot.create(:project, user: brock, title: 'Líder de Ginásio', 
                                              description: 'Me tornar líder do estádio de pedra.',
                                              category: 'Auto Ajuda') 

FactoryBot.create(:task, project: pokemon_project, title:'Pegar um geodude', 
                         description:'Para completar o meu time de pedra, preciso de um geodude, vamos captura-lo',
                         assigned: brock, due_date: 2.months.from_now.to_date, author: brock)

FactoryBot.create(:task, project: pokemon_project, title:'Parar a equipe rocket', 
                         description:'A equipe rocket está aprontando novamente, temos que para-los',
                         assigned: ash, due_date: Time.zone.tomorrow, author: ash)

FactoryBot.create(:task, project: pokemon_project, title:'Derrotar um Charmander',
                         description: 'Lutar contra outro treinador com um Charmander.',
                         assigned: ash, due_date: 1.week.from_now, author: ash)
