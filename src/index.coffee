m = angular.module 'nl2br', []

(->
  Filter = ($sce, $sanitize)->
    (input) ->
      output = input || ''

      #workaround: prevent break of $sanitize tokenizer
      output = output.replace(/</g, '&lt;')
      output = output.replace(/>/g, '&gt;')

      #secure against code injection
      output = $sanitize(output)

      #replace sanitizied new lines
      output = output.replace(/(&#10;&#13;|&#13;&#10;|&#10;|&#13;)/g, '<br>')

      $sce.trustAsHtml(output)

  Filter.$inject = ['$sce', '$sanitize']

  m.filter('nl2br', Filter)
)()

