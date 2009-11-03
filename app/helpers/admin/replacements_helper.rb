module Admin::ReplacementsHelper
  
  def highlight_case_sensitive(text, phrases, *args)
    options = args.extract_options!
    unless args.empty?
      options[:highlighter] = args[0] || '<strong class="highlight">\1</strong>'
    end
    options.reverse_merge!(:highlighter => '<strong class="highlight">\1</strong>')
  
    if text.blank? || phrases.blank?
      text
    else
      match = Array(phrases).map { |p| Regexp.escape(p) }.join('|')
      text.gsub(/(#{match})(?!(?:[^<]*?)(?:["'])[^<>]*>)/, options[:highlighter])
    end
  end
  
  def truncate_and_highlight(content, query, length=100)
    content = strip_tags(content).gsub(/\s+/," ")
    match  = content.match(query)
    if match
      start = match.begin(0)
      begining = (start - length/2)
      begining = 0 if begining < 0
      chars = content.respond_to?(:mb_chars) ? content.mb_chars : content.chars
      relevant_content = chars.length > length ? (chars[(begining)...(begining + length)]).to_s + "..." : content
      if match.post_match.match(query) # Another match in the truncated part
        highlight_case_sensitive(content, query.split)
      else
        highlight_case_sensitive(relevant_content, query.split)
      end
    else
      truncate(content, length)
    end
  end
end