const KEY = "ai-start-editor";
const ALLOWED = ["cursor", "claude", "codex"];

function readEditor() {
  const query = new URLSearchParams(location.search).get("editor");
  if (ALLOWED.includes(query)) return query;
  try {
    const stored = localStorage.getItem(KEY);
    if (ALLOWED.includes(stored)) return stored;
  } catch (_) {
    /* file:// may block storage in some browsers */
  }
  return "cursor";
}

function applyEditor(name, persist) {
  document.body.dataset.editor = name;
  document.querySelectorAll(".editor-btn").forEach((btn) => {
    const on = btn.dataset.editor === name;
    btn.classList.toggle("is-selected", on);
    btn.setAttribute("aria-pressed", on ? "true" : "false");
  });
  if (!persist) return;
  try {
    localStorage.setItem(KEY, name);
  } catch (_) {
    /* ignore */
  }
  try {
    const url = new URL(location.href);
    url.searchParams.set("editor", name);
    history.replaceState(null, "", url);
  } catch (_) {
    /* ignore */
  }
}

applyEditor(readEditor(), false);

document.querySelectorAll(".editor-btn").forEach((btn) => {
  btn.addEventListener("click", () => applyEditor(btn.dataset.editor, true));
});
