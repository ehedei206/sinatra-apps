require 'sinatra'

def  my_path(birthdate)
        my_sum=birthdate[0].to_i+birthdate[1].to_i+birthdate[2].to_i+birthdate[3].to_i+birthdate[4].to_i+birthdate[5].to_i+birthdate[6].to_i+birthdate[7].to_i
        my_sum_str=my_sum.to_s
        my_sum=my_sum_str[0].to_i+my_sum_str[1].to_i

        if my_sum>9
                my_sum_str=my_sum.to_s
                my_sum=my_sum_str[0].to_i+my_sum_str[1].to_i
        end
        return my_sum
end

def create_message(num)
case num
when 1
        message= "One is the leader. The number one indicates the ability to stand alone, and is a strong vibration. Ruled by the Sun."
when 2
        message= "This is the mediator and peace-lover. The number two indicates the desire for harmony. It is a gentle, considerate, and sensitive vibration. Ruled by the Moon."
when 3
        message= "Number Three is a sociable, friendly, and outgoing vibration. Kind, positive, and optimistic, Three's enjoy life and have a good sense of humor. Ruled by Jupiter."
when 4
        message= "This is the worker. Practical, with a love of detail, Fours are trustworthy, hard-working, and helpful. Ruled by Uranus."
when 5
        message= "This is the freedom lover. The number five is an intellectual vibration. These are 'idea' people with a love of variety and the ability to adapt to most situations. Ruled by Mercury."
when 6
        message= "This is the peace lover. The number six is a loving, stable, and harmonious vibration. Ruled by Venus."
when 7
        message= "This is the deep thinker. The number seven is a spiritual vibration. These people are not very attached to material things, are introspective, and generally quiet. Ruled by Neptune."
when 8
        message= "This is the manager. Number Eight is a strong, successful, and material vibration. Ruled by Saturn."
when 9
        message= "This is the teacher. Number Nine is a tolerant, somewhat impractical, and sympathetic vibration. Ruled by Mars."
end

end

def valid_birthdate(input)
	if input.length==8 || 	input.match(/^[0-9]+[0-9]$/)
		return true
	else
		return false
	end
end

def setup_index_view

	birthdate = params[:birthdate]
        my_number=my_path(birthdate)
        @message = create_message(my_number)
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
	if valid_birthdate(birthdate)	
		birth_path_num = my_path(params[:birthdate])
    		redirect "/message/#{birth_path_num}"
	else
		@error="Sorry, your input wasn't valid. Try again!"
		erb :form
	end
end

get '/message/:birth_path_num' do
   birth_path_num = params[:birth_path_num].to_i
   @message = create_message(birth_path_num)
   erb :index
end

