import React, { useEffect, useState } from "react";

const MODELS = [
  { value: "llama3", label: "Llama 3 (Ollama)" },
  { value: "mistral", label: "Mistral (Ollama)" },
  { value: "codellama", label: "CodeLlama (Ollama)" },
  { value: "gpt-3.5-turbo", label: "GPT-3.5 Turbo (OpenAI)" },
  { value: "gpt-4", label: "GPT-4 (OpenAI)" }
];

export default function ModelSelector() {
  const [model, setModel] = useState("llama3");
  const [status, setStatus] = useState<null | string>(null);

  useEffect(() => {
    fetch("/current-model")
      .then((res) => res.json())
      .then((data) => setModel(data.model));
  }, []);

  const handleChange = (e: React.ChangeEvent<HTMLSelectElement>) => {
    const selected = e.target.value;
    setModel(selected);
    setStatus("Changement en cours...");
    fetch("/select-model", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ model: selected })
    })
      .then(() => setStatus("Modèle changé !"))
      .catch(() => setStatus("Erreur"));
    setTimeout(() => setStatus(null), 1700);
  };

  return (
    <div className="model-selector">
      <label>
        <span>🤖 Modèle IA</span>
        <select value={model} onChange={handleChange}>
          {MODELS.map((m) => (
            <option key={m.value} value={m.value}>{m.label}</option>
          ))}
        </select>
      </label>
      {status && <span style={{marginLeft:10, color:"var(--accent)"}}>{status}</span>}
    </div>
  );
}