module GoogleVisualr
  module Rails
    module ViewHelper
      extend ActiveSupport::Concern

      included do
        helper_method "render_chart"
      end

      def render_chart(chart, dom, options={})
        script_tag = options.fetch(:script_tag) { true }
        use_jquery = options.fetch(:use_jquery) { false }
        # binding.pry
        html = ""
        if script_tag          
          html << chart.to_js(dom,use_jquery)
          html.html_safe
        else
          html << chart.load_js(dom)
          html << chart.draw_js(dom)
          html = "jQuery(function($){#{html.html_safe}})"  if use_jquery
          html.html_safe
        end
      end
    end
  end
end
