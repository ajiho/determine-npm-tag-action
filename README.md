# Introduction

This action determines the npm dist-tag based on the git tag.

## Outputs

- `tag` - npm dist-tag to use (`latest` or `alpha`, `beta`, etc.)
- `prerelease` - `true` if it's a prerelease, `false` otherwise

## Example usage

```yaml
jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6

      - name: Npm Auto Tag
        id: auto-tag
        uses: ajiho/npm-auto-tag@main

      - name: Publish to npm
        run: npm publish --tag ${{ steps.auto-tag.outputs.tag }}

      - name: Github Release
        uses: softprops/action-gh-release@v2
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        with:
          prerelease: ${{ steps.auto-tag.outputs.prerelease }}
```
