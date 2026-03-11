<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

use App\Http\Controllers\TaskController;

Route::get('/api/tasks', [TaskController::class, 'index']);
Route::post('/api/tasks', [TaskController::class, 'store']);
Route::put('/api/tasks/{id}', [TaskController::class, 'update']);
Route::delete('/api/tasks/{id}', [TaskController::class, 'destroy']);
