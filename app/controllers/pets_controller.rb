class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end

  get '/pets/new' do 
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do 
    @pets = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(params[:owner]) 
      @pets.update(owner_id: @owner.id)
    end 
    redirect to "/pets/#{@pets.id}"
  end


  get '/pets/:id/edit' do 

    @pet = Pet.find(params[:id])
    @owner = Owner.all
    erb :'/pets/edit'
  end 

  
  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  patch '/pets/:id' do 
    @pet = Pet.find(params[:id])
    @owner = Owner.find(params[:pet][:owner])
    if !params["owner"]["name"].empty?
    @owner = Owner.create(params[:owner])
    @pet.update(name: params[:pet][:name], owner_id: @owner.id)
    else 
      @pet.update(name: params[:pet][:name], owner_id: @owner.id)
    end
    redirect to "/pets/#{@pet.id}"
  end
end