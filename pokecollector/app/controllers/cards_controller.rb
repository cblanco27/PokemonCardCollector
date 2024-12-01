class CardsController < ApplicationController
  before_action :set_card, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:search]

  # GET /cards or /cards.json
  def index
    @cards = Card.all
  end

  # GET /cards/1 or /cards/1.json
  def show
  end

  # GET /cards/new
  def new
    @card = Card.new
  end

  # GET /cards/1/edit
  def edit
  end

  # POST /cards or /cards.json
  def create #changed to automatically assign the User ID when creating cards, so I removed the User portion from the form
    @card = current_user.cards.build(card_params) # Automatically assign the user
    if @card.save
      redirect_to @card, notice: "Card was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/1 or /cards/1.json
  def update
    respond_to do |format|
      if @card.update(card_params)
        format.html { redirect_to @card, notice: "Card was successfully updated." }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cards/1 or /cards/1.json
  def destroy
    @card.destroy!

    respond_to do |format|
      format.html { redirect_to cards_path, status: :see_other, notice: "Card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @cards = Card.all

    # `LIKE` is a case insensitve search operator. allows for 'pikachu', 'PIKACHU', and 'pIkAcHu' to all find the same card in the DB of 'Pikachu'
    # `%#{params[:x]}%` allow for partial string matching. if params[:card_name] == 'pika', the query would pull every card that contained 'Pika' in it
    @cards = @cards.where('card_name LIKE ?', "%#{params[:card_name]}%") if params[:card_name].present?
    @cards = @cards.where('`set` LIKE ?', "%#{params[:set]}%") if params[:set].present?
    @cards = @cards.where('card_type LIKE ?', "%#{params[:card_type]}%") if params[:card_type].present?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card
      @card = Card.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_params
      params.require(:card).permit(:card_name, :card_type, :card_image, :set, :card_price, :user_id)
    end
end
