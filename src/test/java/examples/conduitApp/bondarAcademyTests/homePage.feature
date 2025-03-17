# Documentación oficial donde hay mas ejemplos de validación de esquemas JSON: https://github.com/karatelabs/karate/blob/master/karate-core/src/test/java/com/intuit/karate/core/schema-like.feature

@smokeTest
Feature: Tests for the home page

    Background: Define URL
        * url apiUrl
    
    Scenario: Get all tags
        Given path 'tags'
        When method Get
        Then status 200
        And match response.tags contains ['Test','GitHub','Coding','Git','Enroll','Bondar Academy','Zoom','qa career']
        And match response.tags !contains 'truck'
        And match response.tags == "#array"
        And match each response.tags == "#string"

    Scenario: Get 10 articles from the page
        * def timeValidator = read('classpath:examples/conduitApp/helpers/timeValidator.js');
        Given params {limit: 10, offset: 0}
        And path 'articles'
        When method Get
        Then status 200
        # And match response.articles == '#[10]'
        # And match response.articlesCount == 11
        # And match response == {"articles": "#[10]", "articlesCount": 11}
        * def expectedArticlesCount = response.articlesCount
        And match response == {"articles": "#[10]", "articlesCount": #(expectedArticlesCount)}
        # And match response.articles[0].createdAt contains '2024'
        # And match response.articles[*].favorited contains true
        # Validación especifica y se aplica a los elementos del array articles
        # And match response.articles[*].author.bio contains null
        # Validación más general, que busca el campo bio en cualquier parte de la respuesta JSON
        # And match response..bio contains null
        # And match each response..following == false
        # And match each response..following == '#boolean'
        # And match each response..favoritesCount == '#number'
        # And match each response..bio == '##null OR ##number'
        And match each response.articles ==
        """
            {
                "slug": "#string",
                "title": "#string",
                "description": "#string",
                "body": "#string",
                "tagList": "#array",
                "createdAt": "#? timeValidator(_)",
                "updatedAt": "#? timeValidator(_)",
                "favorited": '#boolean',
                "favoritesCount": '#number',
                "author": {
                    "username": "#string",
                    "bio": "##string",
                    "image": "#string",
                    "following": '#boolean'
                }
            }
        """