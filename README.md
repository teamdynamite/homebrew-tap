# Teamdynamite Tap

A [Homebrew](https://brew.sh) tap for tools by teamdynamite. Formulae build from source, and CI publishes prebuilt bottles, so most users do not need a compiler.

## Formulae

| Formula | Description |
| --- | --- |
| [`git-as`](https://github.com/teamdynamite/git-as) | Switch git identities between saved profiles (`git as <profile>`). |

## How do I install these formulae?

`brew install teamdynamite/tap/<formula>`, for example:

```sh
brew install teamdynamite/tap/git-as
git as -h
```

Or, in a `brew bundle` `Brewfile`:

```ruby
tap "teamdynamite/tap"
brew "teamdynamite/tap/git-as", trusted: true
```

## Releasing a new version of a formula

The example uses `git-as` and version `0.2.0`.

1. Tag and push the release in the `git-as` repository: `git tag -a v0.2.0 -m v0.2.0 && git push origin v0.2.0`.
2. Open a pull request on this tap that updates `url` and `sha256`: `brew bump-formula-pr --no-fork --url=https://github.com/teamdynamite/git-as/archive/refs/tags/v0.2.0.tar.gz teamdynamite/tap/git-as`. The command downloads the tarball, computes the sha256, pushes a branch to this repository, and opens the pull request. It works on the tap that `brew tap teamdynamite/tap` cloned from GitHub, and it needs GitHub credentials (`gh auth login` or `HOMEBREW_GITHUB_API_TOKEN`).
3. Wait for the `brew test-bot` checks on the pull request to pass. They build and test the bottles.
4. Publish: in the Actions tab, select the `brew pr-pull` workflow, click "Run workflow", and enter the pull request number. The workflow uploads the bottles to a GitHub Release, adds the `bottle do` block, and pushes the commits to `main`. The pull request then closes automatically.

> [!WARNING]
> Do not merge a formula pull request with GitHub's merge button. A merge from the button skips the `brew pr-pull` workflow, so the bottles are not published and users must build from source. Use the button only for pull requests that do not change a formula, such as Dependabot updates of the workflows.

## Adding a formula

Add `Formula/<name>.rb` in a pull request, check it locally with `brew audit --strict --online --new teamdynamite/tap/<name>` and `brew style teamdynamite/tap`, then publish it with the `brew pr-pull` workflow as in step 4 above.

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).
