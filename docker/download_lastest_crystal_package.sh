#!/bin/sh

get_latest_release() {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

if [ ${crystal_version} = "latest" ] ; then
  git_tag=$(get_latest_release 'crystal-lang/crystal')
else
  git_tag=${crystal_version}
fi

if [ $1 = "debian" ] ; then
  package_name="crystal_${git_tag}-1_amd64.deb"
  package_path="/tmp/crystal.deb"
else
  package_name="crystal-${git_tag}-1-linux-x86_64.tar.gz"
  package_path="/tmp/crystal.tar.gz"
fi

package_url="https://github.com/crystal-lang/crystal/releases/download/${git_tag}/$package_name"

echo "selected crystal tag is $git_tag"
echo "downloading crystal package from url: $package_url"
curl -L $package_url -o $package_path
