module ApplicationHelper
  def modal_helper path, content, type
    content_tag(:div, :class => 'modal fade', :id => 'app_modal', :tabindex => '-1', :role => 'dialog', 'aria-labelledby' => 'modalLabel')  do   
      content_tag(:div, :class => 'modal-dialog', :role => 'document') do
        content_tag(:div, :class => 'modal-content') do
          content_tag(:div, :class => 'modal-header') do
            content_tag(:button, :class => 'close', 'data-dismiss' => 'modal', 'aria-label' => 'Fechar') do
              content_tag(:span,'X', 'aria-hidden' => true)
            end +
            content_tag(:h4, type, :class => 'modal-title', :id => "modalLabel")
          end +
          content_tag(:div, :class => 'modal-body') do
            content_tag(:label, content)
          end +
          content_tag(:div, :class => 'modal-footer') do          
            form_for(path, :html => { :method => :delete, :id => 'modal_form' }) do
              content_tag(:button, 'Cancelar', :class => 'btn btn-default', 'data-dismiss' => 'modal') +
              content_tag(:button, 'Excluir', :class => 'btn btn-danger', :type => 'submit')
            end
          end
        end
      end
    end
  end
end
