class Application 

    @@item = [Item.new("Orange", 2.00), Item.new("Pear", 1.50)]
    
    def call(env)
        resp = Rack::Response.new
        req = Rack::Request.new(env)

        if req.path.match(/items/)
            find_item = req.path.split("/items/").last
            if item_name = @@item.find{ |item| item.name == find_item}
                resp.write item_name.price 
            else
                resp.status = 400
                resp.write "Item not found"
            end
        else
            resp.write "Route not found"
            resp.status = 404
        end
        resp.finish
    end
end