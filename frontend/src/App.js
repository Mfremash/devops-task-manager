import { useEffect, useState } from "react";

function App() {

  const [tasks, setTasks] = useState([]);
  const [title, setTitle] = useState("");

  const API = "/api/tasks";

  const fetchTasks = async () => {
    const res = await fetch(API);
    const data = await res.json();
    setTasks(data);
  };

  useEffect(() => {
    fetchTasks();
  }, []);

  const addTask = async () => {
    await fetch(API, {
      method: "POST",
      headers: {
        "Content-Type": "application/json"
      },
      body: JSON.stringify({ title })
    });

    setTitle("");
    fetchTasks();
  };

  return (
    <div style={{padding:"40px"}}>
      <h1>Task Manager</h1>

      <input
        value={title}
        onChange={(e) => setTitle(e.target.value)}
        placeholder="New task"
      />

      <button onClick={addTask}>
        Add
      </button>

      <ul>
        {tasks.map(task => (
          <li key={task.id}>
            {task.title}
          </li>
        ))}
      </ul>

    </div>
  );
}

export default App;
