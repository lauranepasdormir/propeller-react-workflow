#!/usr/bin/env bash
# REPO_URL https://github.com/lauranepasdormir/propeller-react-workflow
# Actual commands executed for steps 1-8, in chronological order.
# create-react-app initialized Git and created the initial commit automatically.
# Historical execution record; rerunning against the existing repository is not intended.

cd /Users/cecidiadvous/Documents/Codex/2026-09-11/referenced-chatgpt-conversation-this-is-an/outputs
npx --yes create-react-app@latest propeller-react-workflow --use-npm

cd /Users/cecidiadvous/Documents/Codex/2026-09-11/referenced-chatgpt-conversation-this-is-an/outputs/propeller-react-workflow
git branch -M master

cd /Users/cecidiadvous/Documents/Codex/2026-09-11/referenced-chatgpt-conversation-this-is-an/outputs/propeller-react-workflow
gh repo create lauranepasdormir/propeller-react-workflow --public --source=. --remote=origin --push

cd /Users/cecidiadvous/Documents/Codex/2026-09-11/referenced-chatgpt-conversation-this-is-an/outputs/propeller-react-workflow
set -e
git switch -c update_logo
curl -fL --max-time 45 'https://cdn-ikponof.nitrocdn.com/vGqfYAGlOLDkYkJqZhYIYKEsibdbZnkc/assets/images/optimized/rev-f684a87/www.propelleraero.com/wp-content/uploads/2023/05/footer-logo.svg' -o src/logo.svg
python3 - <<'PY'
from pathlib import Path
p=Path('src/App.js')
p.write_text(p.read_text().replace('https://reactjs.org','https://www.propelleraero.com/dirtmate/').replace('Learn React','Explore DirtMate').replace('alt="logo"','alt="Propeller"'))
p=Path('src/App.test.js')
p.write_text(p.read_text().replace('renders learn react link','renders DirtMate link').replace('/learn react/i','/explore dirtmate/i').replace('expect(linkElement).toBeInTheDocument();', "expect(linkElement).toHaveAttribute('href', 'https://www.propelleraero.com/dirtmate/');"))
p=Path('src/App.css')
s=p.read_text()
start=s.index('.App-logo {')
end=s.index('.App-header {')
s=s[:start]+'.App-logo {\n  width: min(70vw, 465px);\n  height: auto;\n  padding: 24px;\n  background-color: white;\n}\n\n'+s[end:]
s=s[:s.index('@keyframes App-logo-spin')].rstrip()+'\n'
p.write_text(s)
PY
CI=true npm test -- --watchAll=false
npm run build
git add src/App.js src/App.css src/App.test.js src/logo.svg
git commit -m "Replace React branding with Propeller logo and DirtMate link"
git push -u origin update_logo

cd /Users/cecidiadvous/Documents/Codex/2026-09-11/referenced-chatgpt-conversation-this-is-an/outputs/propeller-react-workflow
set -e
cat > /tmp/propeller-react-workflow-pr-body.md <<'EOF'
Replace the default React logo with the requested Propeller SVG and point the app link to DirtMate. Adjust the logo size and background for readability and remove the React spinning animation.

Validation: the DirtMate link test passes and the production build completes successfully.
EOF
gh pr create --base master --head update_logo --title "Replace React logo and link with Propeller DirtMate" --body-file /tmp/propeller-react-workflow-pr-body.md
gh pr merge update_logo --merge
git switch master
git pull --ff-only origin master

