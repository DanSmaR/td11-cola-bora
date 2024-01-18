require 'rails_helper'

describe 'Usuário edita perfil' do
  context 'a partir da tela inicial' do
    it 'pela primeira vez' do
      user = create(:user)
      create(:profile, user:, first_name: '', last_name: '',
                       work_experience: '', education: '')

      login_as user, scope: :user
      visit root_path
      click_on 'Meu perfil'
      click_on 'Completar perfil'

      expect(page).to have_content 'Complete o seu perfil'
      expect(page).to have_field 'Nome'
      expect(page).to have_field 'Sobrenome'
      expect(page).to have_field 'Experiência profissional'
      expect(page).to have_field 'Informação acadêmica'
      expect(page).to have_button 'Atualizar Perfil'
    end

    it 'e já tem informação registrada' do
      user = create(:user)
      create(:profile, user:)

      login_as user, scope: :user
      visit root_path
      click_on 'Meu perfil'
      click_on 'Atualizar perfil'

      expect(page).to have_content 'Atualizar perfil'
    end
  end

  it 'com sucesso' do
    user = create(:user)
    create(:profile, user:, first_name: '', last_name: '',
                     work_experience: '', education: '')

    login_as user, scope: :user
    visit edit_profile_path user.profile
    fill_in 'Nome', with: 'Pedro'
    fill_in 'Sobrenome', with: 'Silva'
    fill_in 'Experiência profissional', with: 'Programador, Designer'
    fill_in 'Informação acadêmica', with: 'Ciências da Computação'
    click_on 'Atualizar Perfil'

    # FIXME: expect(current_path).to eq profile_path(user.profile)
    expect(page).to have_content 'Perfil atualizado com sucesso!'
    expect(page).to have_content 'Nome: Pedro Silva'
    expect(page).to have_content 'Experiência profissional: Programador, Designer'
    expect(page).to have_content 'Informação acadêmica: Ciências da Computação'
  end

  context 'e cancela edição' do
    it 'pela primeira vez' do
      profile = create(:profile, first_name: '', last_name: '',
                                 work_experience: '', education: '')

      login_as profile.user, scope: :user
      visit edit_profile_path profile
      click_on 'Pular etapa'

      expect(current_path).to eq root_path
    end

    it 'e já tem informação registrada' do
      profile = create(:profile, first_name: 'Jhon', last_name: 'Doe',
                                 work_experience: 'Designer', education: 'Superior completo')

      login_as profile.user, scope: :user
      visit edit_profile_path profile
      click_on 'Voltar'

      expect(current_path).to eq profile_path profile
    end
  end

  it 'e não é o dono do perfil' do
    user = create(:user, email: 'user@email.com', cpf: '787.077.980-67')
    other_user = create(:user, email: 'other_user@email.com', cpf: '047.813.770-25')
    create(:profile, first_name: 'Pedro', user:)
    create(:profile, first_name: 'Leandro', user: other_user)

    login_as user
    visit edit_profile_path(other_user.profile)

    expect(page).not_to have_field 'Nome', with: 'Leandro'
    expect(page).to have_field 'Nome', with: 'Pedro'
  end

  it 'e não está autenticado' do
    profile = create(:profile)

    visit edit_profile_path(profile)

    expect(current_path).to eq new_user_session_path
    expect(page).to have_content 'Login'
  end
end
