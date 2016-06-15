class ZombiesController < ApplicationController
  before_action :set_zombie, only: [:show, :edit, :update, :destroy, :decomp, :custom_decomp ]
  # GET /zombies
  # GET /zombies.json
  def index
    @zombies = Zombie.includes(:brain).includes(:tweets).all # use 'includes' to avoid query for each brain, which creates N + 1 issue (slower database)
  end

  # GET /zombies/1
  # GET /zombies/1.json
  def show
    # THIS IS IF YOU NEED BOTH HTML & JSON FORMAT
    respond_to do |format|
      format.html do #show html.erb (this is just to remind us that show.html.erb is where it will be looking for)
        if @zombie.decomp == 'Dead (again)'
          render :dead_again # if you enter value 'Dead (again) in decomp column, you will be redirected to page called: dead_again
        end
      end
      format.json { render json: @zombie }
    end

    # # THIS IS IF YOU NEED HTML ONLY
    #   if @zombie.decomp == 'Dead (again)'
    #     render :dead_again
    #   end

    # THIS IS IF YOU NEED JSON ONLY
      # if @zombie.decomp == 'Dead (again)'
      #   render json: @zombie
      # end
    # THE RESULT WILL BE:
    # {"id":4,"name":"Bob","bio":"","created_at":"2016-05-30T04:55:47.678Z","updated_at":"2016-06-04T12:03:12.359Z","email":null,"rotting":true,"age":27,"decomp":"Dead (again)"}
  end

  # GET /zombies/new
  def new
    @zombie = Zombie.new
  end

  # GET /zombies/1/edit
  def edit
  end

  # POST /zombies
  # POST /zombies.json
  def create
    @zombie = Zombie.new(zombie_params)

    respond_to do |format|
      if @zombie.save
        format.html { redirect_to @zombie, notice: 'Zombie was successfully created.' }
        format.json { render :show, status: :created, location: @zombie }
      else
        format.html { render :new }
        format.json { render json: @zombie.errors, status: :unprocessable_entity }
      end
      format.js # for AJAX form
    end
  end

  # PATCH/PUT /zombies/1
  # PATCH/PUT /zombies/1.json
  def update
    respond_to do |format|
      if @zombie.update(zombie_params)
        format.html { redirect_to @zombie, notice: 'Zombie was successfully updated.' }
        format.json { render :show, status: :ok, location: @zombie }
      else
        format.html { render :edit }
        format.json { render json: @zombie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /zombies/1
  # DELETE /zombies/1.json
  def destroy
    @zombie.destroy
    respond_to do |format|
      # format.html { redirect_to zombies_url, notice: 'Zombie was successfully destroyed.' }
      # format.json { head :no_content }
      # format.json { head :ok }
      format.js #allow the controller to accept the JavaScript call
    end
  end

  def decomp #path name decomp_zombie_path
    if @zombie.decomp == 'Dead (again)'
      # render json: @zombie, status: :unprocessable_entity
      # This will print everything, like this:
      # {"id":3,"name":"Jim","bio":"","created_at":"2016-05-30T04:55:20.960Z","updated_at":"2016-06-10T02:30:55.653Z","email":null,"rotting":false,"age":20,"decomp":"Dead (again)"}
      # render json: @zombie.to_json(only: [:name, :decomp]), status: :unprocessable_entity
      render json: @zombie.to_json(except: [:created_at, :updated_at])
    else
      # render json: @zombie, status: :ok
      # render json: @zombie.to_json(only: [:name, :decomp])
      # render json: @zombie.to_json(include: :brain, except: [:created_at, :updated_at, :id])
      # This will everything in brain :
      # {"name":"Jim","bio":"","email":null,"rotting":false,"age":20,"decomp":"fresh","brain":{"id":3,"zombie_id":3,"status":null,"flavour":"Strawberry","created_at":"2016-05-30T04:55:33.077Z","updated_at":"2016-05-30T04:55:33.077Z"}}

      render json: @zombie.to_json( include: [brain: { only: [:flavour] }], except: [:id, :created_at, :updated_at]
      )
      # This will include brain flavour in the result:
      # {"name":"Jim","bio":"","email":null,"rotting":false,"age":20,"decomp":"fresh","brain":{"flavour":"Strawberry"}}
    end
  end

  def custom_decomp
    @zombie.decomp = params[:zombie][:decomp]
    @zombie.save

    respond_to do |format|
      format.js
      format.json { render json: @zombie.to_json(only: :decomp) }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_zombie
      @zombie = Zombie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def zombie_params
      params.require(:zombie).permit(:name, :bio, :age, :decomp)
    end

end
