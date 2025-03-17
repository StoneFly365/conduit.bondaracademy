@smokeTest
Feature: Articles

    Background: Define URL
        * url apiUrl
        * def articleRequestBody = read('classpath:examples/conduitApp/jsonData/newArticleRequest.json')
        * def dataGenerator = Java.type('examples.conduitApp.helpers.DataGenerator')
        * set articleRequestBody.article.title = dataGenerator.getRandomArticleValues().title
        * set articleRequestBody.article.description = dataGenerator.getRandomArticleValues().description
        * set articleRequestBody.article.body = dataGenerator.getRandomArticleValues().body
        # Ejemplo, definición y obtención de token
        # * def tokenResponse = callonce read('classpath:examples/conduitApp/helpers/createToken.feature')
        # * def token = tokenResponse.authToken

    @ignore
    Scenario: Create a new article
        # Ejemplo, obtección cabecera autorizacicón + token
        # Given header Authorization = 'Token ' + token
        Given path '/articles'
        And request articleRequestBody 
        When method Post
        Then status 201
        And match response.article.title == articleRequestBody.article.title
    
    Scenario: Create and delete article
        # Crear articulo
        # Given header Authorization = 'Token ' + token
        Given path '/articles'
        And request articleRequestBody
        When method Post
        Then status 201
        * def articleId = response.article.slug

        # Comprobar que el articulo se ha creado
        # Given header Authorization = 'Token ' + token
        Given params {limit: 10, offset: 0}
        And path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title == articleRequestBody.article.title
        
       
        # Borrar el artículo creado
        # Given header Authorization = 'Token ' + token
        Given path 'articles', articleId
        When method Delete
        Then status 204

        # Comprobar que el artículo ha sido borrado
        # Given header Authorization = 'Token ' + token
        Given params {limit: 10, offset: 0}
        And path 'articles'
        When method Get
        Then status 200
        And match response.articles[0].title != articleRequestBody.article.title
