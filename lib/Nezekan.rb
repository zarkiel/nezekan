require "nezekan/version"

module Nezekan

    @@secure_action = {}
    @@secure_session = {}

    def secure_action
        raise SecureActionException.new "You aren't authorized to see this action." if @@secure_action.nil?

        action = params[:action]
        #secured_actions = explode(',',preg_replace('/ +/', '',implode(',',array_values($secure_session))))
        #secured_actions = @@secure_session.values.join(',').gsub(/ +/, '').split(',')
        
        if @@secure_action.has_key? :exclude
            exclude_actions = @@secure_action[:exclude].to_s.gsub(/ +/, '').split(',')
            return true if exclude_actions.include? action
        end

        session_name = @@secure_action[:session_name]
        

        @@secure_action.each do |user_type, _actions|
            if user_type != :session_name
                secured_actions = _actions.gsub(/ +/, '').split(',')
                if (secured_actions.include? action or secured_actions.include? '*') and session[session_name] == user_type.to_s
                    return true
                end
            end
        end

        raise SecureActionException.new "You aren't authorized to see this action."
        
    end

    def secure_session
        raise SecureSessionException.new "You aren't authorized to see this action." if @@secure_session.nil?

        action = params[:action]
  
        if @@secure_session.has_key? :exclude
            exclude_actions = @@secure_session[:exclude].to_s.gsub(/ +/, '').split(',')
            return true if exclude_actions.include? action
        end
   
        @@secure_session.each do |_session, _actions|
            
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

