class GovukComponent::WarningTextComponent < GovukComponent::Base
  attr_reader :text, :icon_fallback_text

  ICON = '!'.freeze

  def initialize(text:, icon_fallback_text: 'Warning', classes: [], html_attributes: {})
    super(classes: classes, html_attributes: html_attributes)

    @text = text
    @icon_fallback_text = icon_fallback_text
  end

  def call
    tag.div(class: classes, **html_attributes) do
      safe_join([icon, (content || strong)])
    end
  end

private

  def icon
    tag.span(ICON, class: 'govuk-warning-text__icon', aria: { hidden: true })
  end

  def strong
    tag.strong(class: 'govuk-warning-text__text') do
      safe_join([assistive, text])
    end
  end

  def assistive
    tag.span(icon_fallback_text, class: 'govuk-warning-text__assistive')
  end

  def default_classes
    %w(govuk-warning-text)
  end
end
