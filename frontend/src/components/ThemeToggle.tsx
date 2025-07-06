import React, { useEffect, useState } from "react";

export default function ThemeToggle() {
  const [theme, setTheme] = useState<"light"|"dark">(
    window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light"
  );

  useEffect(() => {
    document.documentElement.setAttribute("data-theme", theme);
    localStorage.setItem("sangus-theme", theme);
  }, [theme]);

  useEffect(() => {
    const saved = localStorage.getItem("sangus-theme");
    if (saved === "dark" || saved === "light") setTheme(saved);
  }, []);

  return (
    <button
      style={{ background:"none", border:"none", cursor:"pointer", marginLeft:8 }}
      title={theme==="dark"?"Mode clair":"Mode sombre"}
      onClick={() => setTheme(theme === "dark" ? "light" : "dark")}
    >
      <img src="/icons/moon-sun.svg" width={24} alt="Mode" />
    </button>
  );
}