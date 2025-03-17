
@smokeTest
Feature: Homework

  Background: Preconditions
    * url apiUrl

  Scenario: Favorite articles
    # Step 1: Get articles of the global feed
    Given path 'articles'
    And params {limit: 10, offset: 0}
    When method Get
    Then status 200

    # Step 2: Get the favorites count and slug ID for the first article, save it to variables
    * def slugId = response.articles[0].slug
    * def initialCount = response.articles[0].favoritesCount
    * print 'slugId: ', slugId
    * print 'initialCount: ', initialCount

    # Step 3: Make POST request to increse favorites count for the first article
    Given path 'articles', slugId, 'favorite'
    And request {}
    When method Post
    Then status 200

    # Step 4: Verify response schema
    And match response.article contains { favoritesCount: '#number', slug: '#string' }

    # Step 5: Verify that favorites article incremented by 1
    * def initialCount = 0
    * def response = {"favoritesCount": 1}
    And match response.favoritesCount == initialCount + 1
    * print 'favoritesCount: ', response.favoritesCount
    * print 'initialCount: ', initialCount + 1

    # Step 6: Get all favorite articles
    Given path 'articles'
    And params {favorited: 'KarateRaul@test.com', limit: 10, offset: 0}
    When method Get
    Then status 200

    # Step 7: Verify response schema
    And match response.articles[*].favorited contains true
    
    # Step 8: Verify that slug ID from Step 2 exist in one of the favorite articles
    And match response.articles[*].slug contains slugId

  Scenario: Comment articles
    # Step 1: Get articles of the global feed
    Given path 'articles'
    And params {limit: 10, offset: 0}
    When method Get
    Then status 200

    # Step 2: Get the slug ID for the first article, save it to variable
    * def slugId = response.articles[0].slug

    # Step 3: Make a GET call to 'comments' end-point to get all comments
    Given path 'articles', slugId, 'comments'
    When method Get
    Then status 200

    # Step 4: Verify response schema
    And match response contains { comments: '#array' }

    # Step 5: Get the count of the comments array lentgh and save to variable
    Given path 'articles', slugId, 'comments'
    When method Get
    Then status 200
    * def commentsCount = response.comments ? response.comments.length : 0
    * print 'Comments length:', response.comments.length
    * print 'Comments Count:', commentsCount
    
    # Step 6: Make a POST request to publish a new comment
    Given path 'articles', slugId, 'comments'
    And request {"comment": {"body": "This is a test comment"}}
    When method Post
    Then status 200

    # Step 7: Verify response schema that should contain posted comment text
    And match response.comment.body == 'This is a test comment'

    # Step 8: Get the list of all comments for this article one more time
    Given path 'articles', slugId, 'comments'
    When method Get
    Then status 200

    # Step 9: Verify number of comments increased by 1 (similar like we did with favorite counts)
    * def newComments = response.comments
    * def newCommentsCount = newComments ? newComments.length : 0
    * print 'newComments:', newComments
    * print 'commentsCount:', commentsCount
    And match newCommentsCount == commentsCount + 1

    # Step 10: Make a DELETE request to delete comment
    * def commentId = newComments[0].id
    Given path 'articles', slugId, 'comments', commentId
    When method Delete
    Then status 200

    # Step 11: Get all comments again and verify number of comments decreased by 1
    Given path 'articles', slugId, 'comments'
    When method Get
    Then status 200
    * def updatedComments = response.comments
    * def updatedCommentsCount = updatedComments ? updatedComments.length : 0
    * print 'updatedComments:', updatedComments
    * print 'updatedCommentsCount:', updatedCommentsCount