workflow "Build, Test, Deploy" {
  on = "push"
  resolves = ["Publish"]
}

action "Build" {
  uses = "actions/npm@e7aaefe"
  args = "install"
}

action "Test" {
  needs = "Build"
  uses = "actions/npm@e7aaefe"
  args = "test"
}

action "Master branch" {
  needs = "Test"
  uses = "actions/bin/filter@b2bea07"
  args = "branch master"
}

action "Publish" {
  needs = "Master branch"
  uses = "actions/npm@e7aaefe"
  args = "publish --access public"
  secrets = ["NPM_AUTH_TOKEN"]
}
