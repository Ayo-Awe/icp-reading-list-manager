import Text "mo:base/Text";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Iter "mo:base/Iter";

actor {
  type ReadingType = {
    #Book;
    #Blog;
    #Article;
  };

  type ReadingEntry = {
    id : Text;
    url : Text;
    done : Bool;
    readingType : ReadingType;
  };

  var readingList = HashMap.HashMap<Text, ReadingEntry>(30, Text.equal, Text.hash);

  public query func getReadingList() : async [ReadingEntry] {
    Iter.toArray<ReadingEntry>(readingList.vals());
  };

  public func createReadingEntry(id : Text, url : Text, readingType : ReadingType) {
    let newReadingEntry : ReadingEntry = {
      id = id;
      url = url;
      readingType = readingType;
      done = false;
    };

    readingList.put(id, newReadingEntry);
  };

  public func markAsDone(id : Text) {
    var ReadingEntry = readingList.get(id);

    switch (ReadingEntry) {
      case (null) {
        // do nothing
      };

      case (?value) {
        var updatedReadingEntry = {
          id = value.id;
          url = value.url;
          readingType = value.readingType;
          done = not value.done;
        };

        readingList.put(value.id, updatedReadingEntry);
      };
    };
  };

  public func deleteReadingEntry(id : Text) {
    readingList.delete(id);
  };

};
