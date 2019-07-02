# Github Sync

A GitHub Action for syncing the current repository using **force push**. 


## Features
 * Sync branches between two Github repositories
 * Sync branches from a remote repository
 * Github action can be triggered on a timer or on push
 * To push to a remote repository, please checkout [wei/git-sync](https://github.com/wei/git-sync)


## Usage

### Github Actions
```
action "repo-sync" {
  uses = "wei/github-sync@master"
  args = "$SOURCE_REPO $SOURCE_BRANCH:$DESTINATION_BRANCH"
  secrets = ["GITHUB_TOKEN"]
  env = {
    SOURCE_REPO = ""
    SOURCE_BRANCH = ""
    DESTINATION_BRANCH = ""
  }
}
```
`GITHUB_TOKEN` must be checked under secrets. 

If `SOURCE_REPO` is private or with another provider, either (1) use an authenticated HTTPS repo clone url like `https://username:access_token@github.com/username/repository.git` or (2) set a `SSH_PRIVATE_KEY` secret and use the SSH clone url


## Known Issue
The job may fail if upstream has a `.workflow` file present. Consider using [git-sync](https://github.com/wei/git-sync) instead.


## Advanced Usage: Sync all branches
1. Make a backup
2. Create a new branch in your repo (destination repo), it should not share the name with any branch in source repo
3. Make the new branch the default branch under repo settings
4. Use `*:*` in place of `$SOURCE_BRANCH:$DESTINATION_BRANCH`

This will force sync ALL branches to match source repo. Branches that are created only in the destination repo will not be affected but all the other branches will be *hard reset* to match source repo. ⚠️ This does mean if upstream ever creates a branch that shares the name, your changes will be gone.


## Author
[Wei He](https://github.com/wei) _github@weispot.com_


## License
[MIT](https://wei.mit-license.org)
