require "nezekan/version"

module Nezekan
	def secure_action(secured_actions, expected_value)
		raise SecureActionException.new "You aren't authorized to see this action." if secured_actions.nil?

		action = params[:action]

		if secured_actions.has_key? :exclude
			exclude_actions = secured_actions[:exclude].to_s.gsub(/ +/, '').split(',')
			return true if exclude_actions.include? action
		end


		secured_actions.each do |user_type, _actions|
			if user_type != :session_name
				secured_actions = _actions.gsub(/ +/, '').split(',')
				if (secured_actions.include? action or secured_actions.include? '*') and expected_value == user_type.to_s
					return true
				end
			end
		end

		raise SecureActionException.new "You aren't authorized to see this action." 
		
	end

    def secure_session(secured_sessions)
        raise SecureSessionException.new "You aren't authorized to see this action." if secured_sessions.nil?

        action = params[:action]
  
        if secured_sessions.has_key? :exclude
            exclude_actions = secured_sessions[:exclude].to_s.gsub(/ +/, '').split(',')
            return true if exclude_actions.include? action
        end
   
		secured_sessions.each do |_session, _actions|
            
            secured_actions = _actions.gsub(/ +/, '').split(',')
            if (secured_actions.include? action or secured_actions.include? '*') and not session[_session].nil?
                return true
            end
          
        end

        raise SecureSessionException.new "You aren't authorized to see this action."
        
    end

    class SecureActionException < ::StandardError

    end

    class SecureSessionException < ::StandardError

    end
end

