class BlogContentPolicy < ApplicationPolicy
    POLICIES = %i[update? delete? show? search? index? create? destroy?]
    
    POLICIES.each do |policy|
        # just skip if you manually define custom policy for paricular method
        next if respond_to?(policy)

        define_method policy do
            # can add admin , editor, etc
            # return true if user.admin? || user.editor?
            if record.respond_to?(:to_a)
                return true if record.empty?
                record.pluck(:user_id).uniq.include? @user.id
            else
                record.user_id == @user.id
            end
        end
    end
end