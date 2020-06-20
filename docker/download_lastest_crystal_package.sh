#!/bin/sh

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

latest_tag=$(get_latest_release 'crystal-lang/crystal')

if [ $1 = "debian" ] ; then
  package_name="crystal_${latest_tag}-1_amd64.deb"
  package_path="/tmp/crystal.deb"
else
  package_name="crystal-${latest_tag}-1-linux-x86_64.tar.gz"
  package_path="/tmp/crystal.tar.gz"
fi

package_url="https://github.com/crystal-lang/crystal/releases/download/0.35.1/$package_name"

echo "latest tag is $latest_tag"
echo "downloading latest package from $package_url"
curl -L $package_url -o $package_path
