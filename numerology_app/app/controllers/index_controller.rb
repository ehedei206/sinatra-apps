require 'sinatra'


def setup_index_view

	birthdate = params[:birthdate]
        my_number=Person.my_path(birthdate)
        @message = "Your numerology number is " + Person.create_message(my_number)
        erb :index

end

get '/newpage' do
	erb :newpage
end

get '/:birthdate' do

	setup_index_view
end

get '/' do
	erb :form
end

post '/' do
	
	birthdate = params[:birthdate]
	if Person.valid_birthdate(birthdate)	
		birth_path_num = Person.my_path(params[:birthdate])
    		redirect "/message/#{birth_path_num}"
	else
		@error="You should enter a valid birthdate in the form of mmddyyyy."
		erb :form
	end
end

get '/message/:birth_path_num' do
   birth_path_num = params[:birth_path_num].to_i
   @message = Person.create_message(birth_path_num)
   erb :index
end


