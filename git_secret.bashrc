git_secrets(){

curl -s https://api.github.com/orgs/$1/repos?per_page=200 | jq -r '.[].clone_url' | xargs -n 1 trufflehog  --regex --entropy=True

}

local_git_secrets(){
mkdir local_github ; cd local_github
curl -s https://api.github.com/orgs/$1/repos?per_page=200 | jq -r '.[].clone_url' | xargs -n 1 git clone  ; find . -type f -print | grep -v ".git" | xargs -n 1 cat | gf secret
}
