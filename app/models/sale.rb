class Sale < ApplicationRecord
	##asscoations
	has_many :product_items, dependent: :destroy
  has_many :products, through: :product_items, dependent: :destroy
  accepts_nested_attributes_for :product_items, reject_if: :all_blank, allow_destroy: true

  before_save :update_subtotal

## validation

    validates :total_price,  :presence => true

		#validates :has_product_item

    # def has_product_item
		#   	 errors.add(:base, 'can not be null') if self.product_items.empty?
	  # end
		
## scope

    scope :recently_sold, lambda { where('created_at >= ?', 1.week.ago)}
    scope :down_sale, lambda { where(:type_of_sales => "Down Sales") }
    scope :normal_sale, lambda { where(:type_of_sales => "Normal") }
    scope :credit_sale, lambda { where(:type_of_sales => "Credit") }
    scope :total_sold, lambda { order("created_at DESC")}

  def total_price
    product_items.collect { |oi| oi.valid? ? (oi.quantity * oi.selling_price) : 0 }.sum
  end


  private

  def update_subtotal
    self[:total_price] = total_price
  end

end
