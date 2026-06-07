#!/usr/bin/env bash
# ============================================================================
# Fabric Mod Template — Initialisation Script
# ============================================================================
# Replaces all placeholders in the template with values for your new mod.
#
# Usage:
#   ./init-mod.sh <MOD_ID> <MOD_NAME> <PACKAGE> <MAVEN_GROUP> [CLASS_NAME]
#
# Arguments:
#   MOD_ID      – lowercase mod id, e.g. "auto-sprint"
#   MOD_NAME    – human-readable name, e.g. "Auto Sprint"
#   PACKAGE     – Java package, e.g. "com.example.autosprint"
#   MAVEN_GROUP – Maven group, e.g. "com.example"
#   CLASS_NAME  – main class name (optional, defaults to "MainMod")
#
# Example:
#   ./init-mod.sh auto-sprint "Auto Sprint" com.example.autosprint com.example AutoSprintMod
# ============================================================================

set -euo pipefail

if [ $# -lt 4 ]; then
    echo "Usage: $0 <MOD_ID> <MOD_NAME> <PACKAGE> <MAVEN_GROUP> [CLASS_NAME]"
    echo ""
    echo "Example:"
    echo "  $0 auto-sprint \"Auto Sprint\" com.example.autosprint com.example AutoSprintMod"
    exit 1
fi

MOD_ID="$1"
MOD_NAME="$2"
PACKAGE="$3"
MAVEN_GROUP="$4"
CLASS_NAME="${5:-MainMod}"
ARCHIVES_NAME="${MOD_ID//_/-}"
DESCRIPTION="A Minecraft Fabric mod."

echo "============================================"
echo " Initialising Fabric Mod: $MOD_NAME"
echo "============================================"
echo "  Mod ID:       $MOD_ID"
echo "  Name:         $MOD_NAME"
echo "  Package:      $PACKAGE"
echo "  Maven Group:  $MAVEN_GROUP"
echo "  Class:        $CLASS_NAME"
echo "  Archive:      $ARCHIVES_NAME"
echo "============================================"
echo ""

# ---------- Step 1: Replace text in files ----------
echo "[1/4] Replacing placeholders in files..."

FILES=(
    "gradle.properties"
    "src/main/resources/fabric.mod.json"
    "src/main/resources/template-mod.mixins.json"
    "src/main/java/com/example/template/TemplateMod.java"
    "src/main/java/com/example/template/mixin/ExampleMixin.java"
    "src/main/resources/assets/template-mod/lang/en_us.json"
    "src/main/resources/assets/template-mod/lang/zh_cn.json"
)

for f in "${FILES[@]}"; do
    if [ -f "$f" ]; then
        sed -i.bak \
            -e "s/template-mod/${MOD_ID}/g" \
            -e "s/Template Mod/${MOD_NAME}/g" \
            -e "s/com\.example\.template/${PACKAGE}/g" \
            -e "s/com\.example/${MAVEN_GROUP}/g" \
            -e "s/TemplateMod/${CLASS_NAME}/g" \
            -e "s/archives_base_name=template-mod/archives_base_name=${ARCHIVES_NAME}/g" \
            -e "s/A Minecraft Fabric mod built from the fabric-mod-template./${DESCRIPTION}/g" \
            "$f"
        rm -f "${f}.bak"
        echo "  ✓ $f"
    fi
done

# ---------- Step 2: Rename directories ----------
echo "[2/4] Renaming package directories..."

OLD_PKG_PATH="src/main/java/com/example/template"
NEW_PKG_PATH="src/main/java/$(echo "$PACKAGE" | tr '.' '/')"

if [ -d "$OLD_PKG_PATH" ] && [ "$OLD_PKG_PATH" != "$NEW_PKG_PATH" ]; then
    mkdir -p "$(dirname "$NEW_PKG_PATH")"
    mv "$OLD_PKG_PATH" "$(dirname "$NEW_PKG_PATH")/"
    # Clean up empty parent dirs
    find src/main/java -type d -empty -delete 2>/dev/null || true
    echo "  ✓ $OLD_PKG_PATH → $NEW_PKG_PATH"
fi

# ---------- Step 3: Rename class files ----------
echo "[3/4] Renaming class files..."

if [ -f "$NEW_PKG_PATH/TemplateMod.java" ] && [ "$CLASS_NAME" != "TemplateMod" ]; then
    mv "$NEW_PKG_PATH/TemplateMod.java" "$NEW_PKG_PATH/${CLASS_NAME}.java"
    echo "  ✓ TemplateMod.java → ${CLASS_NAME}.java"
fi

# ---------- Step 4: Rename resource directories ----------
echo "[4/4] Renaming resource directories..."

OLD_ASSETS="src/main/resources/assets/template-mod"
NEW_ASSETS="src/main/resources/assets/${MOD_ID}"

if [ -d "$OLD_ASSETS" ] && [ "$OLD_ASSETS" != "$NEW_ASSETS" ]; then
    mkdir -p "$(dirname "$NEW_ASSETS")"
    mv "$OLD_ASSETS" "$NEW_ASSETS"
    echo "  ✓ $OLD_ASSETS → $NEW_ASSETS"
fi

OLD_MIXIN="src/main/resources/template-mod.mixins.json"
NEW_MIXIN="src/main/resources/${MOD_ID}.mixins.json"
if [ -f "$OLD_MIXIN" ] && [ "$OLD_MIXIN" != "$NEW_MIXIN" ]; then
    mv "$OLD_MIXIN" "$NEW_MIXIN"
    echo "  ✓ $OLD_MIXIN → $NEW_MIXIN"
fi

# ---------- Done ----------
echo ""
echo "============================================"
echo " Mod '$MOD_NAME' initialised successfully!"
echo "============================================"
echo ""
echo "Next steps:"
echo "  1. Review the files and customise further"
echo "  2. ./gradlew build"
echo "  3. ./gradlew runClient"
