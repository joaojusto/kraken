PullRequests = new Mongo.Collection("pullRequests");

if (Meteor.isClient) {
  Template.getPullRequests.events({
    'submit': function (event) {
      event.preventDefault();
      var org = $('#org').val();
      var repo = $('#repo').val();
      Meteor.call('getPRs', org, repo, function (error, result) {
        if (error)
          console.log(error);
        else
          console.log(result);
          result.result.forEach(function(pr){
            console.log(pr.title);
            Meteor.call('addPRs', pr.title);
          });
      });
    }
  });

  Template.getPullRequests.helpers({
    pullRequests: function () {
      var prs = PullRequests.find().fetch();
      console.log(prs.title);
      return prs;
    }
  });
}

if (Meteor.isServer) {
  Meteor.startup(function () {
    Meteor.methods({
      'addPRs': function addPRs (title) {
        PullRequests.insert({
          title: title
        });
      },

      'getPRs': function getPRs (org, repo) {
        var GithubApi = Meteor.npmRequire('github');
        var github = new GithubApi({
          version: "3.0.0",
          // optional
          debug: true,
          protocol: "https",
          pathPrefix: "/api/v3", // for some GHEs
          timeout: 5000,
          headers: {
            "user-agent": "My-Cool-GitHub-App", // GitHub is happy with a unique user agent
          }
        });
        var prs = Async.runSync(function(done) {
          github.pullRequests.getAll({
            // optional:
            // headers: {
            //     "cookie": "blahblah"
            // },
            user: org,
            repo: repo
          }, function(err, res) {
            done(null, res);
          });
        });
        return prs;
      }
    });
  });
}
