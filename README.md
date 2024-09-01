# GitHub Sync
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-6-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

A GitHub Action for syncing the current repository using **force push**.


## Features
 * Sync branches between two GitHub repositories
 * Sync branches from a remote repository
 * GitHub action can be triggered on a timer or on push
 * To push to a remote repository, please checkout [git-sync](https://github.com/marketplace/actions/git-sync-action)
 * Support syncing tags.


## Usage

Create a personal access token and add to repository's secret as `PAT`

### GitHub Actions
```
# File: .github/workflows/repo-sync.yml

on:
  schedule:
  - cron:  "*/15 * * * *"
  workflow_dispatch:

jobs:
  repo-sync:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v4
      with:
        persist-credentials: false
    - name: repo-sync
      uses: repo-sync/github-sync@v2
      with:
        source_repo: ""
        source_branch: ""
        destination_branch: ""
        sync_tags: ""
        github_token: ${{ secrets.PAT }}
```
If `source_repo` is private or with another provider, either (1) use an authenticated HTTPS repo clone url like `https://${access_token}@github.com/owner/repository.git` or (2) set a `SSH_PRIVATE_KEY` secret environment variable and use the SSH clone url

### Workflow overwriting

If `destination_branch` and the branch where you will create this workflow will be the same, The workflow (and all files) will be overwritten by `source_branch` files. A potential solution is: Create a new branch with the actions file and make it the default branch. You can update `sync_tags` to match tags you want to sync, e.g `android-14.0.0_*`.

## Advanced Usage: Sync all branches
1. Make a backup
2. Create a new branch in your repo (destination repo), it should not share the name with any branch in source repo
3. Make the new branch the default branch under repo settings
4. Use `*` for both `source_branch` and `destination_branch`
5. Optionally, you can force sync all tags:
   ```
   with:
     sync_tags: "true" # or * to match all tags.
   ```
This will force sync ALL branches to match source repo. Branches that are created only in the destination repo will not be affected but all the other branches will be *hard reset* to match source repo. ⚠️ This does mean if upstream ever creates a branch that shares the name, your changes will be gone.

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://whe.me"><img src="https://avatars3.githubusercontent.com/u/5880908?v=4" width="100px;" alt=""/><br /><sub><b>Wei He</b></sub></a><br /><a href="https://github.com/repo-sync/github-sync/commits?author=wei" title="Code">💻</a> <a href="https://github.com/repo-sync/github-sync/commits?author=wei" title="Documentation">📖</a> <a href="#design-wei" title="Design">🎨</a> <a href="#ideas-wei" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="http://zeke.sikelianos.com"><img src="https://avatars1.githubusercontent.com/u/2289?v=4" width="100px;" alt=""/><br /><sub><b>Zeke Sikelianos</b></sub></a><br /><a href="https://github.com/repo-sync/github-sync/commits?author=zeke" title="Documentation">📖</a> <a href="#ideas-zeke" title="Ideas, Planning, & Feedback">🤔</a></td>
    <td align="center"><a href="https://alexpage.com.au"><img src="https://avatars1.githubusercontent.com/u/19199063?v=4" width="100px;" alt=""/><br /><sub><b>Alex Page</b></sub></a><br /><a href="https://github.com/repo-sync/github-sync/issues?q=author%3Aalex-page" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/xtqqczze"><img src="https://avatars1.githubusercontent.com/u/45661989?v=4" width="100px;" alt=""/><br /><sub><b>xtqqczze</b></sub></a><br /><a href="https://github.com/repo-sync/github-sync/commits?author=xtqqczze" title="Code">💻</a> <a href="https://github.com/repo-sync/github-sync/commits?author=xtqqczze" title="Documentation">📖</a></td>
    <td align="center"><a href="https://unstoppable.software"><img src="https://avatars1.githubusercontent.com/u/70325615?v=4" width="100px;" alt=""/><br /><sub><b>Kay Harrison-Sims</b></sub></a><br /><a href="https://github.com/repo-sync/github-sync/issues?q=author%3AGlitchShtick" title="Bug reports">🐛</a></td>
    <td align="center"><a href="https://github.com/Gibby"><img src="https://avatars3.githubusercontent.com/u/503761?v=4" width="100px;" alt=""/><br /><sub><b>Gibby</b></sub></a><br /><a href="https://github.com/repo-sync/github-sync/commits?author=Gibby" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
