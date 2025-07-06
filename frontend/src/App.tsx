import ThemeToggle from "./components/ThemeToggle";
import logo from "/logo-sangus.svg"; // Vite ou webpack

export default function App() {
  return (
    <div className="sangus-root">
      <aside className="sangus-sidebar">
        <img src={logo} alt="Sangus" style={{width:120, margin:"0 auto 2rem"}} />
        <ThemeToggle />
        {/* ...autres composants */}
      </aside>
      {/* ... */}
    </div>
  );
}