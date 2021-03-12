// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class ArtistsQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Artists($search: String!, $first: Int!, $after: String) {
      search {
        __typename
        artists(query: $search, first: $first, after: $after) {
          __typename
          nodes {
            __typename
            ...ArtistBasicFragment
          }
        }
      }
    }
    """

  public let operationName: String = "Artists"

  public var queryDocument: String { return operationDefinition.appending("\n" + ArtistBasicFragment.fragmentDefinition) }

  public var search: String
  public var first: Int
  public var after: String?

  public init(search: String, first: Int, after: String? = nil) {
    self.search = search
    self.first = first
    self.after = after
  }

  public var variables: GraphQLMap? {
    return ["search": search, "first": first, "after": after]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("search", type: .object(Search.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(search: Search? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "search": search.flatMap { (value: Search) -> ResultMap in value.resultMap }])
    }

    /// Search for MusicBrainz entities using Lucene query syntax.
    public var search: Search? {
      get {
        return (resultMap["search"] as? ResultMap).flatMap { Search(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "search")
      }
    }

    public struct Search: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["SearchQuery"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("artists", arguments: ["query": GraphQLVariable("search"), "first": GraphQLVariable("first"), "after": GraphQLVariable("after")], type: .object(Artist.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(artists: Artist? = nil) {
        self.init(unsafeResultMap: ["__typename": "SearchQuery", "artists": artists.flatMap { (value: Artist) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      /// Search for artist entities matching the given query.
      public var artists: Artist? {
        get {
          return (resultMap["artists"] as? ResultMap).flatMap { Artist(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "artists")
        }
      }

      public struct Artist: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["ArtistConnection"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("nodes", type: .list(.object(Node.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(nodes: [Node?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "ArtistConnection", "nodes": nodes.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// A list of nodes in the connection (without going through the
        /// `edges` field).
        public var nodes: [Node?]? {
          get {
            return (resultMap["nodes"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Node?] in value.map { (value: ResultMap?) -> Node? in value.flatMap { (value: ResultMap) -> Node in Node(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Node?]) -> [ResultMap?] in value.map { (value: Node?) -> ResultMap? in value.flatMap { (value: Node) -> ResultMap in value.resultMap } } }, forKey: "nodes")
          }
        }

        public struct Node: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Artist"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
              GraphQLField("name", type: .scalar(String.self)),
              GraphQLField("disambiguation", type: .scalar(String.self)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID, name: String? = nil, disambiguation: String? = nil) {
            self.init(unsafeResultMap: ["__typename": "Artist", "id": id, "name": name, "disambiguation": disambiguation])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The ID of an object
          public var id: GraphQLID {
            get {
              return resultMap["id"]! as! GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          /// The official name of the entity.
          public var name: String? {
            get {
              return resultMap["name"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          /// A comment used to help distinguish identically named entitites.
          public var disambiguation: String? {
            get {
              return resultMap["disambiguation"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "disambiguation")
            }
          }

          public var fragments: Fragments {
            get {
              return Fragments(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }

          public struct Fragments {
            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public var artistBasicFragment: ArtistBasicFragment {
              get {
                return ArtistBasicFragment(unsafeResultMap: resultMap)
              }
              set {
                resultMap += newValue.resultMap
              }
            }
          }
        }
      }
    }
  }
}

public final class ArtistQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query Artist($artistIdentifier: ID!) {
      node(id: $artistIdentifier) {
        __typename
        ...ArtistDetailsFragment
      }
    }
    """

  public let operationName: String = "Artist"

  public var queryDocument: String { return operationDefinition.appending("\n" + ArtistDetailsFragment.fragmentDefinition) }

  public var artistIdentifier: GraphQLID

  public init(artistIdentifier: GraphQLID) {
    self.artistIdentifier = artistIdentifier
  }

  public var variables: GraphQLMap? {
    return ["artistIdentifier": artistIdentifier]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("node", arguments: ["id": GraphQLVariable("artistIdentifier")], type: .object(Node.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(node: Node? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "node": node.flatMap { (value: Node) -> ResultMap in value.resultMap }])
    }

    /// Fetches an object given its ID
    public var node: Node? {
      get {
        return (resultMap["node"] as? ResultMap).flatMap { Node(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "node")
      }
    }

    public struct Node: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Area", "Artist", "Recording", "Release", "Disc", "Label", "Collection", "Event", "Instrument", "Place", "ReleaseGroup", "Series", "Work", "URL"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLTypeCase(
            variants: ["Artist": AsArtist.selections],
            default: [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            ]
          )
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public static func makeArea() -> Node {
        return Node(unsafeResultMap: ["__typename": "Area"])
      }

      public static func makeRecording() -> Node {
        return Node(unsafeResultMap: ["__typename": "Recording"])
      }

      public static func makeRelease() -> Node {
        return Node(unsafeResultMap: ["__typename": "Release"])
      }

      public static func makeDisc() -> Node {
        return Node(unsafeResultMap: ["__typename": "Disc"])
      }

      public static func makeLabel() -> Node {
        return Node(unsafeResultMap: ["__typename": "Label"])
      }

      public static func makeCollection() -> Node {
        return Node(unsafeResultMap: ["__typename": "Collection"])
      }

      public static func makeEvent() -> Node {
        return Node(unsafeResultMap: ["__typename": "Event"])
      }

      public static func makeInstrument() -> Node {
        return Node(unsafeResultMap: ["__typename": "Instrument"])
      }

      public static func makePlace() -> Node {
        return Node(unsafeResultMap: ["__typename": "Place"])
      }

      public static func makeReleaseGroup() -> Node {
        return Node(unsafeResultMap: ["__typename": "ReleaseGroup"])
      }

      public static func makeSeries() -> Node {
        return Node(unsafeResultMap: ["__typename": "Series"])
      }

      public static func makeWork() -> Node {
        return Node(unsafeResultMap: ["__typename": "Work"])
      }

      public static func makeURL() -> Node {
        return Node(unsafeResultMap: ["__typename": "URL"])
      }

      public static func makeArtist(id: GraphQLID, name: String? = nil, disambiguation: String? = nil, rating: AsArtist.Rating? = nil) -> Node {
        return Node(unsafeResultMap: ["__typename": "Artist", "id": id, "name": name, "disambiguation": disambiguation, "rating": rating.flatMap { (value: AsArtist.Rating) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var fragments: Fragments {
        get {
          return Fragments(unsafeResultMap: resultMap)
        }
        set {
          resultMap += newValue.resultMap
        }
      }

      public struct Fragments {
        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public var artistDetailsFragment: ArtistDetailsFragment? {
          get {
            if !ArtistDetailsFragment.possibleTypes.contains(resultMap["__typename"]! as! String) { return nil }
            return ArtistDetailsFragment(unsafeResultMap: resultMap)
          }
          set {
            guard let newValue = newValue else { return }
            resultMap += newValue.resultMap
          }
        }
      }

      public var asArtist: AsArtist? {
        get {
          if !AsArtist.possibleTypes.contains(__typename) { return nil }
          return AsArtist(unsafeResultMap: resultMap)
        }
        set {
          guard let newValue = newValue else { return }
          resultMap = newValue.resultMap
        }
      }

      public struct AsArtist: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Artist"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
            GraphQLField("name", type: .scalar(String.self)),
            GraphQLField("disambiguation", type: .scalar(String.self)),
            GraphQLField("rating", type: .object(Rating.selections)),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID, name: String? = nil, disambiguation: String? = nil, rating: Rating? = nil) {
          self.init(unsafeResultMap: ["__typename": "Artist", "id": id, "name": name, "disambiguation": disambiguation, "rating": rating.flatMap { (value: Rating) -> ResultMap in value.resultMap }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        /// The ID of an object
        public var id: GraphQLID {
          get {
            return resultMap["id"]! as! GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        /// The official name of the entity.
        public var name: String? {
          get {
            return resultMap["name"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        /// A comment used to help distinguish identically named entitites.
        public var disambiguation: String? {
          get {
            return resultMap["disambiguation"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "disambiguation")
          }
        }

        /// The rating users have given to this entity.
        public var rating: Rating? {
          get {
            return (resultMap["rating"] as? ResultMap).flatMap { Rating(unsafeResultMap: $0) }
          }
          set {
            resultMap.updateValue(newValue?.resultMap, forKey: "rating")
          }
        }

        public var fragments: Fragments {
          get {
            return Fragments(unsafeResultMap: resultMap)
          }
          set {
            resultMap += newValue.resultMap
          }
        }

        public struct Fragments {
          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public var artistDetailsFragment: ArtistDetailsFragment {
            get {
              return ArtistDetailsFragment(unsafeResultMap: resultMap)
            }
            set {
              resultMap += newValue.resultMap
            }
          }
        }

        public struct Rating: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Rating"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("value", type: .scalar(Double.self)),
              GraphQLField("voteCount", type: .nonNull(.scalar(Int.self))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(value: Double? = nil, voteCount: Int) {
            self.init(unsafeResultMap: ["__typename": "Rating", "value": value, "voteCount": voteCount])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          /// The average rating value based on the aggregated votes.
          public var value: Double? {
            get {
              return resultMap["value"] as? Double
            }
            set {
              resultMap.updateValue(newValue, forKey: "value")
            }
          }

          /// The number of votes that have contributed to the rating.
          public var voteCount: Int {
            get {
              return resultMap["voteCount"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "voteCount")
            }
          }
        }
      }
    }
  }
}

public struct ArtistBasicFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment ArtistBasicFragment on Artist {
      __typename
      id
      name
      disambiguation
    }
    """

  public static let possibleTypes: [String] = ["Artist"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("disambiguation", type: .scalar(String.self)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String? = nil, disambiguation: String? = nil) {
    self.init(unsafeResultMap: ["__typename": "Artist", "id": id, "name": name, "disambiguation": disambiguation])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The ID of an object
  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  /// The official name of the entity.
  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// A comment used to help distinguish identically named entitites.
  public var disambiguation: String? {
    get {
      return resultMap["disambiguation"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "disambiguation")
    }
  }
}

public struct ArtistDetailsFragment: GraphQLFragment {
  /// The raw GraphQL definition of this fragment.
  public static let fragmentDefinition: String =
    """
    fragment ArtistDetailsFragment on Artist {
      __typename
      id
      name
      disambiguation
      rating {
        __typename
        value
        voteCount
      }
    }
    """

  public static let possibleTypes: [String] = ["Artist"]

  public static var selections: [GraphQLSelection] {
    return [
      GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
      GraphQLField("id", type: .nonNull(.scalar(GraphQLID.self))),
      GraphQLField("name", type: .scalar(String.self)),
      GraphQLField("disambiguation", type: .scalar(String.self)),
      GraphQLField("rating", type: .object(Rating.selections)),
    ]
  }

  public private(set) var resultMap: ResultMap

  public init(unsafeResultMap: ResultMap) {
    self.resultMap = unsafeResultMap
  }

  public init(id: GraphQLID, name: String? = nil, disambiguation: String? = nil, rating: Rating? = nil) {
    self.init(unsafeResultMap: ["__typename": "Artist", "id": id, "name": name, "disambiguation": disambiguation, "rating": rating.flatMap { (value: Rating) -> ResultMap in value.resultMap }])
  }

  public var __typename: String {
    get {
      return resultMap["__typename"]! as! String
    }
    set {
      resultMap.updateValue(newValue, forKey: "__typename")
    }
  }

  /// The ID of an object
  public var id: GraphQLID {
    get {
      return resultMap["id"]! as! GraphQLID
    }
    set {
      resultMap.updateValue(newValue, forKey: "id")
    }
  }

  /// The official name of the entity.
  public var name: String? {
    get {
      return resultMap["name"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "name")
    }
  }

  /// A comment used to help distinguish identically named entitites.
  public var disambiguation: String? {
    get {
      return resultMap["disambiguation"] as? String
    }
    set {
      resultMap.updateValue(newValue, forKey: "disambiguation")
    }
  }

  /// The rating users have given to this entity.
  public var rating: Rating? {
    get {
      return (resultMap["rating"] as? ResultMap).flatMap { Rating(unsafeResultMap: $0) }
    }
    set {
      resultMap.updateValue(newValue?.resultMap, forKey: "rating")
    }
  }

  public struct Rating: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Rating"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("value", type: .scalar(Double.self)),
        GraphQLField("voteCount", type: .nonNull(.scalar(Int.self))),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(value: Double? = nil, voteCount: Int) {
      self.init(unsafeResultMap: ["__typename": "Rating", "value": value, "voteCount": voteCount])
    }

    public var __typename: String {
      get {
        return resultMap["__typename"]! as! String
      }
      set {
        resultMap.updateValue(newValue, forKey: "__typename")
      }
    }

    /// The average rating value based on the aggregated votes.
    public var value: Double? {
      get {
        return resultMap["value"] as? Double
      }
      set {
        resultMap.updateValue(newValue, forKey: "value")
      }
    }

    /// The number of votes that have contributed to the rating.
    public var voteCount: Int {
      get {
        return resultMap["voteCount"]! as! Int
      }
      set {
        resultMap.updateValue(newValue, forKey: "voteCount")
      }
    }
  }
}
