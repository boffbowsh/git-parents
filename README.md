Usage:

```
bundle install
./search path/to/repo
```

Finds commits in a repo that:

- Have two parents, e.g. a merge commit
- Both parents only have a single parent, e.g. not a merge commit.

This should not happen in Github Flow, as the only commits to master should be merge commits of Pull Requests.

```
M-\ Merge PR
o | Direct-to-master commit, suspicious
| o Branch commit
M-/ Previous PR Merge
```

Only searches the last year. Change the `THRESHOLD` constant to adjust this.

Outputs the ancestor commit (a merge commit) and then the two parents. It's not predictable which parent would be suspicious, so inspect both. Best way to do this is with a visual git commit tree tool like Gitk, GitX or tig.

