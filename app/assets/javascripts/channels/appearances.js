(function() {
  jQuery(document).on('turbolinks:load', function() {
    return App.personal_chat = App.cable.subscriptions.create({
      channel: "AppearancesChannel"
    }, {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        var user;
        user = $(".user-" + data['user_id']);
        return user.toggleClass('online', data['online']);
      }
    });
  });

}).call(this);
