<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Task;
use Carbon\Carbon;
use Illuminate\Support\Facades\Auth;

class TaskController extends Controller
{
    public function index()
    {
        $user = Auth::user();

        $tasks = Task::where('user_id', $user->id)
            ->orderBy('due_date', 'asc')
            ->get();

        return response()->json($tasks, 200, [], JSON_PRETTY_PRINT);
    }

    public function search(Request $request)
    {
        $user = Auth::user();
        $query = $request->input('query');
        $tasks = Task::where('user_id', $user->id)
            ->where(function ($q) use ($query) {
                $q->where('title', 'like', "%{$query}%")
                  ->orWhere('description', 'like', "%{$query}%");
            })
            ->orderBy('due_date', 'asc')
            ->get();
        return response()->json($tasks, 200, [], JSON_PRETTY_PRINT);
    }

    public function store(Request $request)
    {
        $user = Auth::user();
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'due_date' => 'required|date|after_or_equal:today',
            'is_important' => 'boolean',
            'is_done' => 'boolean',
            'description' => 'nullable|string',
            'completed_at' => 'nullable|date',
        ]);
        $validated['due_date'] = Carbon::parse($validated['due_date'])->toDateString();
        $validated['user_id'] = $user->id;
        if (!isset($validated['completed_at'])) {
            $validated['completed_at'] = ($validated['is_done'] ?? false)
                ? Carbon::now()
                : null;
        }
        $task = Task::create($validated);

        return response()->json([
            'message' => 'Task berhasil dibuat',
            'task' => $task,
        ], 201);
    }

    public function update(Request $request, $id)
    {
        $user = Auth::user();
        $validated = $request->validate([
            'title' => 'required|string|max:255',
            'due_date' => 'required|date|after_or_equal:today',
            'is_done' => 'boolean',
            'is_important' => 'boolean',
            'description' => 'nullable|string',
            'completed_at' => 'nullable|date',
        ]);

        $task = Task::where('id', $id)
            ->where('user_id', $user->id)
            ->firstOrFail();
            $validated['due_date'] = Carbon::parse($validated['due_date'])->toDateString();
            if (isset($validated['is_done'])) {
            if ($validated['is_done'] && !$task->is_done) {
                $validated['completed_at'] = Carbon::now(); 
                } elseif (!$validated['is_done'] && $task->is_done) {
                $validated['completed_at'] = null;
                } else {
                $validated['completed_at'] = $task->completed_at;
            }
        }

        $task->update($validated);
        return response()->json([
            'message' => 'Task berhasil diperbarui',
            'task' => $task,
        ], 200);
    }

    public function toggleDone($id)
    {
        $user = Auth::user();
        $task = Task::where('id', $id)
            ->where('user_id', $user->id)
            ->firstOrFail();
        $task->is_done = !$task->is_done;
        $task->completed_at = $task->is_done
            ? Carbon::now()   // Simpan waktu lengkap saat centang
            : null;
        $task->save();

        return response()->json([
            'message' => 'Status task diperbarui',
            'task' => $task,
        ], 200);
    }

    public function destroy($id)
    {
        $user = Auth::user();
        $task = Task::where('id', $id)
            ->where('user_id', $user->id)
            ->first();
        if (!$task) {
            return response()->json(['message' => 'Task tidak ditemukan'], 404);
        }
        $task->delete();
        return response()->json(['message' => 'Task berhasil dihapus'], 200);
    }
}
