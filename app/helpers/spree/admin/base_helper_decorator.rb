module Spree
  module Admin
    BaseHelper.module_eval do
      
      def mega_menu_build id
        mega_menu = MegaMenu.find(id).build_menu        
      end
  
      def get_mega_menu_link mega_menu_item, options = {prefix: '', suffix:'', class:'', count:1}
        
        url = link = mega_menu_item.link
        
        if mega_menu_item.type_of_link == "taxon"
          
          if self.is_number? link
            url =  Spree::Taxon.where(id: mega_menu_item.link).first
            
          elsif link.is_a? String
            url = Spree::Taxon.find_by_name(mega_menu_item.link)
            
          end
          
          if url.is_a? Spree::Taxon
              url = seo_url(url)
          end
        end
        
        # Build menu link
        "<a class='cd-dropdown-item' href='#{url}'>
          #{options[:prefix]} #{mega_menu_item.title} #{options[:suffix]}
        </a>".html_safe
      end
      
      def is_number? string
        true if Float(string) rescue false
      end
      
      def column_name num 
        case num
        when 1 
          "left"
        when 2
          "right"
        end
      end
      
    end
  end
end