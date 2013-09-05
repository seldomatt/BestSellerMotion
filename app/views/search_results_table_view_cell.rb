class SearchResultsTableViewCell < UITableViewCell

  attr_accessor :title, :author, :publisher

  def initWithStyle(style, reuseIdentifier: identifier)
    super.tap do
      self.stylesheet = :results_cell
      self.selectionStyle = UITableViewCellSelectionStyleNone
      layout(self.contentView, :content) do
        @title = subview(UILabel, :title)
        @author = subview(UILabel, :author)
        @publisher = subview(UILabel, :publisher)
        subview("cell-splitter".uiimageview, :splitter)
      end
      self.apply_constraints
    end
  end

end

Teacup::Stylesheet.new(:results_cell) do

  GREEN_COLOR = "#99C7B3".uicolor
  TEXT_COLOR = :white.uicolor

  style :content,
        backgroundColor: GREEN_COLOR


  style :title, :author, :publisher,
        backgroundColor: GREEN_COLOR,
        color: TEXT_COLOR,
        numberOfLines: 0,
        lineBreakMode: NSLineBreakByWordWrapping

  style :title,
        constraints: [
          constrain_top(10),
          constrain_left(10)
        ],
        font: "Helvetica-Bold".uifont(16),
        preferredMaxLayoutWidth: 300

  style :author,
        constraints: [
          constrain(:left).equals(:title, :left),
          constrain_below(:title,5),
          #constrain(:baseline).equals(:title, :baseline).plus(15),
          constrain_height(20),
          constrain_width(200)
        ],
        font: "Helvetica".uifont(15)

  style :publisher,
        constraints: [
          constrain(:left).equals(:author, :left),
          constrain(:baseline).equals(:author, :baseline).plus(20),
          constrain_height(20),
          constrain_width(200)
        ],
        font: "Helvetica".uifont(15)

  style :splitter,
        constraints: [
          :center_x,
          constrain_bottom(0)
        ]

end