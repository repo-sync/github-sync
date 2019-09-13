# GitHub Sync
[![All Contributors](https://img.shields.io/badge/all_contributors-3-orange.svg?style=flat-square)](#contributors)

A GitHub Action for syncing the current repository using **force push**. 


## Features
 * Sync branches between two GitHub repositories
 * Sync branches from a remote repository
 * GitHub action can be triggered on a timer or on push
 * To push to a remote repository, please checkout [git-sync](https://github.com/marketplace/actions/git-sync-action)


## Usage

### GitHub Actions
```
# File: .github/workflows/repo-sync.yml

on:
  schedule:
  - cron:  "*/15 * * * *"
jobs:
  repo-sync:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@master
    - name: repo-sync
      uses: repo-sync/github-sync@v2
      with:
        source_repo: ""
        source_branch: ""
        destination_branch: ""
        github_token: ${{ secrets.GITHUB_TOKEN }}
```
If `source_repo` is private or with another provider, either (1) use an authenticated HTTPS repo clone url like `https://${access_token}@github.com/owner/repository.git` or (2) set a `SSH_PRIVATE_KEY` secret environment variable and use the SSH clone url


## Advanced Usage: Sync all branches
1. Make a backup
2. Create a new branch in your repo (destination repo), it should not share the name with any branch in source repo
3. Make the new branch the default branch under repo settings
4. Use `*` for both `source_branch` and `destination_branch`

This will force sync ALL branches to match source repo. Branches that are created only in the destination repo will not be affected but all the other branches will be *hard reset* to match source repo. ⚠️ This does mean if upstream ever creates a branch that shares the name, your changes will be gone.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table>
  <tr>
    <td align="center"><a href="https://whe.me"><img src="https://avatars3.githubusercontent.com/u/5880908?v=4" width="100px;" alt="Wei He"/><br /><sub><b>Wei He</b></sub></a><br /><a href="https://github.com/repo-sync/github-sync/commits?author=wei" title="Code">💻</a> <a href="https://github.com/repo-sync/github-sync/commits?author=wei" title="Documentation">📖</a> <a href="#design-wei" title="Design">🎨</a> <a href="#ideas-wei" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="http://zeke.sikelianos.com"><img src="https://avatars1.githubusercontent.com/u/2289?v=4" width="100px;" alt="Zeke Sikelianos"/><br /><sub><b>Zeke Sikelianos</b></sub></a><br /><a href="https://github.com/repo-sync/github-sync/commits?author=zeke" title="Documentation">📖</a> <a href="#ideas-zeke" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://alexpage.com.au"><img src="https://avatars1.githubusercontent.com/u/19199063?v=4" width="100px;" alt="Alex Page"/><br /><sub><b>Alex Page</b></sub></a><br /><a href="https://github.com/repo-sync/github-sync/issues?q=author%3Aalex-page" title="Bug reports">🐛</a></td>
  </tr>
</table>

<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!