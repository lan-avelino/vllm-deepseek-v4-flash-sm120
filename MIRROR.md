# Mirror

This repository is a mirror. Upstream development happens at
[ormandj/vllm-deepseek-v4-flash-sm120](https://github.com/ormandj/vllm-deepseek-v4-flash-sm120),
which is the authoritative source for the Containerfiles, patches, and lock
files here. All authorship and attribution belong upstream (see `NOTICE` and
`LICENSE`); this copy exists so the source and the published container images
stay available if the upstream repository or its GHCR package is deleted.

Nothing here is rebuilt. The mirrored image is a byte-identical copy of the
upstream manifest, pinned by digest, so its digest matches upstream exactly.

## Mirrored images

| Tag | Digest | Upstream source |
| --- | --- | --- |
| `v20` | `sha256:dc19ea2f75d8217cbb0fbc01d8734af79b02e84f0c9cda49e1c137db2c5c902b` | `ghcr.io/ormandj/vllm-deepseek-v4-flash-sm120:v20` |

Pull the mirror by digest, which is reproducible regardless of where the tag
later points:

```
docker pull ghcr.io/lan-avelino/vllm-deepseek-v4-flash-sm120@sha256:dc19ea2f75d8217cbb0fbc01d8734af79b02e84f0c9cda49e1c137db2c5c902b
```

Or by tag:

```
docker pull ghcr.io/lan-avelino/vllm-deepseek-v4-flash-sm120:v20
```

Both refer to the same image as the upstream `:v20` tag did when it was
mirrored. Run instructions are unchanged from the upstream `README.md` — only
the registry path differs.

## Refreshing or adding images

`mirror.lock.json` is the list of images to mirror, each pinned by digest. To
mirror another upstream tag, resolve its digest and add an entry:

```
crane digest ghcr.io/ormandj/vllm-deepseek-v4-flash-sm120:<tag>
```

Then run the **Mirror upstream image** workflow (Actions tab, `workflow_dispatch`)
with the tag name, or `all` to reconcile every locked entry. The workflow copies
registry-to-registry inside ghcr.io, verifies the mirrored digest equals the
locked digest, and pulls every blob back to confirm the tag is actually
pullable. It warns without failing if the upstream tag has since moved to a
different digest, and always mirrors the locked digest.

This package is public: GHCR gave it the visibility of the public repository it
is linked to, and it was confirmed anonymously pullable after mirroring. Public
packages carry no GHCR storage or egress charges. If a future mirrored package
comes out private, make it public under **Package settings → Danger Zone →
Change visibility**, otherwise its storage and every pull outside GitHub
Actions are billed.

## Syncing new upstream commits

The mirror has no fork relationship with upstream, so pull new commits directly:

```
git remote add upstream https://github.com/ormandj/vllm-deepseek-v4-flash-sm120.git
git fetch upstream
git merge --ff-only upstream/main
git push origin main
```
