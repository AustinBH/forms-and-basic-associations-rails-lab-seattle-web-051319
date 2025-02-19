class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    self.genre ? self.genre.name : nil
  end

  def note_contents=(notes)
    updated_notes = notes.select {|note| note != ""}
    updated_notes.each do |note|
      new_note = self.notes.build(content: note)
      new_note.save
    end
    self.notes
  end

  def note_contents
    self.notes.map {|note|note.content}
  end
end
