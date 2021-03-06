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
    #binding.pry
    pet = Pet.create(name: params["pet"]["name"], owner_id: params["pet"]["owner_id"]) # Pet in memory and a pet in the DB
    if !params["owner_name"].empty?
      pet.owner_id = Owner.create(name: params["owner_name"]).id # Owner in memory and a pet in the DB + associated the owner to the pet in memory
    end
    pet.save
    redirect to "pets/#{pet.id}"
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    erb :'pets/edit'
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    # binding.pry
    @pet = Pet.find(params[:id])
    @pet.update(params["pet"])
    if !params["owner"]["name"].empty?
      @pet.owner_id = Owner.create(name: params["owner"]["name"]).id
    end
    @pet.save
    redirect to "pets/#{@pet.id}"
  end
end
