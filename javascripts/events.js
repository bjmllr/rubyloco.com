!function(){var e;e=function(){function e(){this.source=$("#event-template").html(),this.template=Handlebars.compile(this.source)}return e.prototype.get_events=function(){var e,t=this;return e="http://api.meetup.com//2/events/?group_id=8825222&status=upcoming&order=time&limited_events=False&desc=false&offset=0&format=json&page=200&fields=&sig_id=9228642&sig=7e9df3f8cdbe03c41cb42ee8aa90def04e71bf68&callback=loadEvents",$.ajax(e,{dataType:"jsonp",success:function(e){var n,i,o,s,r;for(s=e.results,r=[],i=0,o=s.length;o>i;i++)n=s[i],t.coming_soon(n.time)&&r.push(t.add_event(n));return r}})},e.prototype.add_event=function(e){return e.date=moment(e.time).format("MM/DD/YYYY h:mma"),e.description=e.description.replace(/<img\ssrc.+"><\/img>/,""),e.description=e.description.replace(/\<(\/)?p\>/g,""),e.description=e.description.replace(/\<br(\s)?(\/)?\>/g,""),e.description=new Handlebars.SafeString(e.description),void 0===e.venue&&(e.venue={name:"TBD"}),$("#events").append(this.template(e))},e.prototype.coming_soon=function(e){return moment(e).isBefore(moment().add("months",2))},e}(),$(function(){var t;return t=new e,t.get_events()})}.call(this);