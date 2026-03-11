<?php

namespace App\Http\Controllers;

use App\Models\Task;
use Illuminate\Http\Request;

class TaskController extends Controller
{
    public function index()
    {
        return response()->json(Task::all());
    }

    public function store(Request $request)
    {
        $task = Task::create([
            'title' => $request->title,
            'completed' => false
        ]);

        return response()->json($task, 201);
    }

    public function update(Request $request, $id)
    {
        $task = Task::findOrFail($id);

        $task->update([
            'title' => $request->title ?? $task->title,
            'completed' => $request->completed ?? $task->completed
        ]);

        return response()->json($task);
    }

    public function destroy($id)
    {
        Task::destroy($id);

        return response()->json([
            'message' => 'Task deleted'
        ]);
    }
}
