#!/bin/bash
set -e
if [ ! -x "$HOME/.elan/bin/lake" ]; then
  curl -sSf https://raw.githubusercontent.com/leanprover/elan/master/elan-init.sh | sh -s -- -y --default-toolchain none
fi
export PATH="$HOME/.elan/bin:$PATH"
mkdir -p "$HOME/.config/tauceti"
cat > "$HOME/.config/tauceti/lake-config.toml" <<'CFG'
[[cache.service]]
name = "tauceti-public"
kind = "s3"
artifactEndpoint = "https://cache.taucetiproject.org/artifacts"
revisionEndpoint = "https://cache.taucetiproject.org/revisions"
CFG
for d in */; do
  if [ -f "$d/lean-toolchain" ] && grep -q '^name = "TauCeti"' "$d/lakefile.toml" 2>/dev/null; then
    (cd "$d" && lake exe cache get && LAKE_CACHE_DIR="$PWD/.lake/cache" \
      LAKE_CONFIG="$HOME/.config/tauceti/lake-config.toml" lake cache get \
      --service tauceti-public --repo TauCetiProject/TauCeti --mappings-only) || true
  fi
done
