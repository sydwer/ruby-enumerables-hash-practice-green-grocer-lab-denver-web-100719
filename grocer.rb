def consolidate_cart(cart)
 consolidated_cart = {}
 cart.each do |items|
   items.each do |item_name,price_info|
     if consolidated_cart[item_name]
       consolidated_cart[item_name][:count] +=1 
     else 
       consolidated_cart[item_name] = price_info
       consolidated_cart[item_name][:count] = 1 
     end
   end
 end
 return consolidated_cart
end

def apply_coupons(cart,coupons)
  coupons.each do |specific_coupon|
  an_item = specific_coupon[:item]
  if cart[an_item]
    if cart[an_item][:count] >= specific_coupon[:num] && !cart["#{an_item} W/COUPON"]
      cart["#{an_item} W/COUPON"] = { :price => specific_coupon[:cost]/specific_coupon[:num], :clearance => cart[an_item][:clearance], :count => specific_coupon[:num]}
      cart[an_item][:count] -= specific_coupon[:num]
    elsif cart[an_item][:count] >= specific_coupon[:num] && cart["#{an_item} W/COUPON"]
      cart["#{an_item} W/COUPON"][:count] += specific_coupon[:num]
      cart[an_item][:count] -= specific_coupon[:num]
    end
  end
end
cart
end

def apply_clearance(cart)
 cart.each do |dinge, info|
   if cart[dinge][:clearance]
   cart[dinge][:price] -= cart[dinge][:price] * 0.2 
 end
 end
 cart
 end
 
 def checkout(cart, coupons)
   middleman_cart = consolidate_cart(cart)
   apply_coupons(middleman_cart, coupons)
   apply_clearance(middleman_cart)
   total = 0
   middleman_cart.each do |items, their_info|
   total += (their_info[:price] * their_info[:count])
  end
  if total >= 100
    total *= 0.9
  end
  return total
end




    

