class Merchant::DiscountsController < Merchant:: BaseController

  def index
    @discounts = Discount.all
  end

  def new

  end

  def create
    merchant = Merchant.find(current_user.merchant_id)
    @discount = merchant.discounts.new(discount_params)
    @discount.save
      flash[:success] = "Discount has been created."
      redirect_to merchant_discounts_path
  end

  def edit
    @discount = Discount.find(params[:id])
  end

  def update
    @discount = Discount.find(params[:id])
    @discount.update(discount_params)
    @discount.save
    redirect_to merchant_discounts_path
  end

  def destroy
    discount = Discount.find(params[:id])
    discount.destroy
    redirect_to merchant_discounts_path
  end

  private
  def discount_params
    params.permit(:discount_percent, :min_quantity)
  end
end
