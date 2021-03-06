class LootsController < ApplicationController
  before_filter :require_admin
  before_filter :find_loot, :only => [:show, :edit, :update, :destroy, :price]
  before_filter :raids_select, :only => [:new, :edit]
  before_filter :prepare_params, :only => [:create, :update]

  cache_sweeper :index_sweeper, :only => [:create, :update, :destroy]

  def index
    @loots = Loot.includes(:item, :raid, :member).order("purchased_on DESC").paginate(:page => params[:page], :per_page => 40)

    respond_to do |wants|
      wants.html
    end
  end

  def new
    @loot = Loot.new

    respond_to do |wants|
      wants.html
    end
  end

  def edit
    respond_to do |wants|
      wants.html
    end
  end

  def create
    @loot = Loot.new(params[:loot])

    respond_to do |wants|
      if @loot.save
        flash[:success] = 'Loot was successfully created.'
        wants.html { redirect_to(loots_path) }
      else
        wants.html do
          raids_select
          render :action => "new"
        end
      end
    end
  end

  def update
    respond_to do |wants|
      if @loot.update_attributes(params[:loot])
        flash[:success] = 'Loot was successfully updated.'
        wants.html { redirect_to(loots_path) }
      else
        wants.html do
          raids_select
          render :action => 'edit'
        end
      end
    end
  end

  def destroy
    @loot.destroy

    flash[:success] = 'Loot was successfully deleted.'

    respond_to do |wants|
      wants.html { redirect_to(loots_path) }
    end
  end

  # Use Juggy::ItemPrice to price an item based on this loot's properties
  # def price
  #   return if @loot.item_id.nil? or @loot.item.wow_id.blank?

  #   wow_class = ( @loot.member_id.nil? ) ? nil : @loot.member.wow_class
  #   new_price = ItemPrice.instance.price(:name => @loot.item.name,
  #     :slot => @loot.item.slot, :level => @loot.item.level, :class => wow_class)

  #   respond_to do |wants|
  #     wants.html { render :text => new_price }
  #     wants.js { render :text => new_price }
  #   end
  # end

  private
    def find_loot
      @loot = Loot.find(params[:id])
    end

    def raids_select
      @raids = Raid.order('date DESC')

      if @loot.nil?
        @raids = @raids.where("date >= ?", 52.days.ago)
      else
        # Make sure we include the date this loot was purchased on even if it's
        # now outside our loot factor cutoff
        @raids = @raids.where("date >= ? OR date = ?", 52.days.ago, @loot.purchased_on)
      end
    end

    def prepare_params
      # If given the item's exact ID, we don't need to know its name
      return unless params[:loot].present? and params[:loot][:item_id].present?
      params[:loot].delete(:item_name) if params[:loot][:item_id].present?
    end
end
