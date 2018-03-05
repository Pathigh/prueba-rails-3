class OrdersController < ApplicationController
	before_action :authenticate_user!

  def index
		@orders = current_user.orders.where(listo: false)
		
		@total = @orders.inject(0) {|total, order|total += order.work.valor}
		@subtotal = @orders.inject(0) {|subtotal, order|subtotal += order.work.valor * order.quantity}
		
	end

	def show
		
	end


  def empty_card
		current_user.orders.destroy_all

		redirect_to orders_path, notice: 'Se ha vaciado tus tareas'
		
	end

  def destroy
			@order = Order.find(params[:id])

			if @order.quantity == 1

			   if @order.destroy

			   	redirect_to orders_path, notice: 'Tarea Actualizada'
			   else
			   	redirect_to orders_path, alert: 'Error al actualizar'
			   end

			elsif @order.quantity > 1

				 @order.quantity -= 1

				 if @order.save

					redirect_to orders_path, notice: 'Carro Actualizado'
				else
					redirect_to orders_path, alert: 'Error al actualizar'
				end
			end
			
	end

  def create
        @previous_orders = Order.find_by(user_id: current_user.id, work_id: params[:work_id], listo: false)

        if @previous_order.present?
            new_quantity = @previous_order.quantity + 1
            @previous_order.update(quantity: new_quantity)
            redirect_to root_path, notice: 'La tarea se ha generado con exito'
        else
            @order = Order.new()
            @order.work = Work.find(params[:work_id])
            @order.user = current_user

        if @order.save
            redirect_to root_path, notice: 'La Tarea ha sido agregado a su perfil'
        else
            redirect_to root_path, alert: 'La Tarea no ha sido agregado a su perfil'    
        end
    end
 end
end
