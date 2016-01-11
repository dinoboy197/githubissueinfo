# githubissueinfo
Automatically attaches system info to an existing GitHub issue.

## Development

### Publishing

* To create a new release candidate branch and release:
  * git stash
  * git checkout master
  * vi debian/changelog # add entry for new release
  * vi debian/README.Debian # add entry for new release
  * vi debian/README.Source # add entry for new release
  * git add debian/changelog debian/README.Debian debian/README.Source && git commit -m "Prepare release <version>" # use new release version
  * git push origin master
  * git checkout -b <new candidate release branch identifier>
  * git tag <release version>
  * git push origin <new candidate release branch identifier> --tags
  * git checkout master
  * git stash pop
* To create patch of existing release series:
  * git stash
  * git checkout <release branch>
  * git cherry-pick -x <sha> # do this repeatedly for shas to integrate
  * vi debian/changelog # add entry for new release
  * vi debian/README.Debian # add entry for new release
  * vi debian/README.Source # add entry for new release
  * git add debian/changelog debian/README.Debian debian/README.Source && git commit -m "Prepare release <version>" # use new release version
  * git tag <release version>
  * git push origin <new candidate release branch identifier> --tags
  * git checkout master
  * git stash pop

`./makedeb-src.sh <version>` will create and upload source packages to [the repository in Launchpad](https://launchpad.net/~track16/+archive/ubuntu/ppa/+packages). Note that the version specified must be a git reference (preferrably a tag).
