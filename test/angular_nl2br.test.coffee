describe 'angular-nl2br', ->
  {nl2br, sce} = {}

  beforeEach ->
    module('nl2br')
    module("ngSanitize")
    inject ($injector, $filter, $sce) ->
      sce = $injector.get '$sce'
      nl2br = $filter 'nl2br'

  it 'turns unix-style newlines into <br> tags', ->
    input = 'AWWWWWK!\n\nPolly want a cracker?\n\nAWWWWK!'
    expect(sce.getTrustedHtml(nl2br(input))).to.equal 'AWWWWWK!<br><br>Polly want a cracker?<br><br>AWWWWK!'

  it 'turns windows-style newlines into <br> tags', ->
    input = 'AWWWWWK!\r\n\r\nPolly want a cracker?\r\n\r\nAWWWWK!'
    expect(sce.getTrustedHtml(nl2br(input))).to.equal 'AWWWWWK!<br><br>Polly want a cracker?<br><br>AWWWWK!'

  it 'does return empty result if input is undefined', ->
    expect(nl2br(undefined)).to.equal ''

  it 'does not print executable code', ->
    input = 'This is a text.\n<script>alert("hello world");</script>\nAnd this a new line!'
    expect(sce.getTrustedHtml(nl2br(input))).to.equal 'This is a text.<br>&lt;script&gt;alert(&#34;hello world&#34;);&lt;/script&gt;<br>And this a new line!'

  it 'does not crash when an unfinished HTML token is entered', ->
    input = 'Entering <i should not throw an exception'
    expect(sce.getTrustedHtml(nl2br(input))).to.equal 'Entering &lt;i should not throw an exception'
