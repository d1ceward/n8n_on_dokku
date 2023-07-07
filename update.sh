# Pull upstream changes
echo -e "\033[0;32m====>\033[0m Pull origin..."
git pull

echo -e "\033[0;32m====>\033[0m Initial check..."

# Get current release name
CURRENT_RELEASE=$(git tag | tail -1)

# Get lastest release name
RELEASE=$(curl -s https://api.github.com/repos/n8n-io/n8n/releases/latest | jq -r ".tag_name" | sed 's/n8n@//g; s/\"//g')

# Exit script if already up to date
if [ $RELEASE = $CURRENT_RELEASE ]; then
  echo -e "\033[0;32m=>\033[0m Already up to date..."
  exit 0
fi

# Replace "from" line in dockerfile with the new release
sed -i "s#ARG N8N_VERSION.*#ARG N8N_VERSION=\"${RELEASE}\"#" Dockerfile

# Replace README link to n8n release
N8N_BADGE="[![n8n](https://img.shields.io/badge/n8n-${RELEASE}-blue.svg)](https://github.com/n8n-io/n8n/releases/tag/n8n%40${RELEASE})"
sed -i "s#\[\!\[n8n\].*#${N8N_BADGE}#" README.md

# Push changes
git add Dockerfile README.md
git commit -m "Update to n8n version ${RELEASE}"
git push origin master

# Create tag
git tag $RELEASE
git push --tags
