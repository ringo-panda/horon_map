module ApplicationHelper

  def get_horon_direction_to_root(node_horon_id)
    direction = []
    flag = false
    node_horon = Horon.find(node_horon_id)
    direction.unshift(node_horon)
    while node_horon.parent_id.present? && flag == false
      node_horon = Horon.find(node_horon.parent_id)
      direction.each do |d|
        if d.id == node_horon.id
          flag = true
        end
      end
      direction.unshift(node_horon)
    end
    return direction
  end
end
