class GovukComponent::SummaryListComponent::RowComponent < GovukComponent::Base
  attr_reader :key, :value, :href, :text, :visually_hidden_text, :action_classes, :action_attributes

  def initialize(key:, value:, action: {}, classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @key   = key
    @value = value

    if action.present?
      @href                 = action[:href]
      @text                 = action[:text] || "Change"
      @visually_hidden_text = " #{action[:visually_hidden_text] || key.downcase}"
      @action_classes       = action[:classes] || []
      @action_attributes    = action[:html_attributes] || {}
    end
  end

  def action
    link_classes = govuk_link_classes.append(action_classes).flatten

    tag.dd(class: "govuk-summary-list__actions") do
      if href.present?
        link_to(href, class: link_classes, **action_attributes) do
          safe_join([text, tag.span(visually_hidden_text, class: "govuk-visually-hidden")])
        end
      end
    end
  end

private

  def default_classes
    %w(govuk-summary-list__row)
  end
end
