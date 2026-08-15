function applyDeploy() {
  const deploy = window.AI_START_DEPLOY;
  const section = document.getElementById("step-3");
  const link = document.getElementById("deploy-link");
  const name = document.getElementById("deploy-name");
  if (!section || !link) return;
  if (!deploy || !deploy.url) {
    section.hidden = true;
    return;
  }
  section.hidden = false;
  link.href = deploy.url;
  link.textContent = deploy.url.replace(/^https:\/\//, "");
  if (name) name.textContent = deploy.name ? `Проект ${deploy.name}` : "";
}

applyDeploy();
