class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  # GET /members.json  
  def index
    @members = Member.all
    @members=Member.search(params) 
    @member=@members.first
    @width = 400   if @member
    @height = 200 if @member
    
    if @member
      puts "@members.first:#{@members.first}.name" 
      @preview_page_1=@members.first.preview_page_1
      @preview_page_2=@members.first.preview_page_2
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @members }
    end
  end

  # GET /members/1
  # GET /members/1.json
  def show
    @preview_page_1=@member.preview_page_1
    @preview_page_2=@member.preview_page_2
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    @member = Member.new(member_params)

    respond_to do |format|
      if @member.save        
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
        format.json { render :show, status: :created, location: @member }
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    # expire_page :action => :show
    respond_to do |format|
      if @member.update(member_params)
        @member.generate_pdf
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def order
    @order=Order.new
    @order.member_id=params[:id]
    @order.delivery="택배"
    @order.save
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      # params.require(:member).permit(:name, :email, :variables, :company_id)
      params.require(:member).permit(:name, :email, :company_id, variables: params[:member][:variables].try(:keys))
    end
    
    
end
