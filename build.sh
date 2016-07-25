export REPO="$(pwd | sed s,^/home/travis/build/,,g)"
echo -e "Current Repo:$REPO --- Travis Branch:$TRAVIS_BRANCH"

#Set git user
git config --global user.email "David.Weber42@Outlook.com"
git config --global user.name "Vidisters Travis"

#Set upstream remote
git remote add upstream https://${GH_TOKEN}@github.com/GJTrier/gruene-jugend-trier.de.git > /dev/null

git fetch -qn upstream > /dev/null

if [ "$TRAVIS_BRANCH" == "master" ]; then
    git checkout gh-pages
    nanoc
    git add -f output/.
    git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to gh-pages"
    git subtree push --prefix output origin gh-pages > /dev/null
    #git push https://${GH_TOKEN}@github.com/${REPO} gh-pages > /dev/null
fi