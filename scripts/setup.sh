#!/bin/bash

BASE_THEME="bathe"
THEME_NAME=""
WP_CONTENT="wp-content"
THEMES_DIR="./$WP_CONTENT/themes"
echo "We will start to setup a theme right now!"

# handle arguments
for i in "$@"; do
case $i in
    -t=*|--themename=*)
    THEME_NAME="${i#*=}"
    shift
    ;;
    --help)
    echo "Utility Usage:"
    echo "--"
    echo "./scripts/setup.sh -t=THEME_NAME"
    shift
    ;;
    *)
        echo "Unknown option: ${i#*=}"
    ;;
esac
done

if [ "$THEME_NAME" == "" ]; then
    if [ -d "$WP_CONTENT" ]; then
        THEME_NAME=$(basename $(pwd))
    fi
    if [ "$THEME_NAME" == "" ]; then
        echo ""
        echo "Please define the variable for THEME_NAME within your environment"
        echo "or supply the theme name as an argument: -t=theme-name"
        exit
    fi
fi

PLATFORM='unknown'
DETECTED=$(uname | tr '[:upper:]' '[:lower:]')
if [[ "$DETECTED" == 'linux' ]]; then
   PLATFORM='linux'
elif [[ "$DETECTED" == 'darwin' ]]; then
   PLATFORM='macos'
fi

CWD=$(pwd)
echo "Current working directory is: $CWD"

echo "Copying theme files..."
cp -R $THEMES_DIR/$BASE_THEME $THEMES_DIR/$THEME_NAME

