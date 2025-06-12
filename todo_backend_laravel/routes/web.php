<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;

Route::get('/', function () {
    return view('welcome');
});

Route::get('/db-test', function () {
    try {
        DB::connection()->getPdo();
        return "✅ Koneksi ke database berhasil!";
    } catch (\Exception $e) {
        return "❌ Gagal koneksi DB: " . $e->getMessage();
    }
});
Route::get('/cek-waktu', function () {
    return '⏰ Sekarang: ' . Carbon::now()->toDateTimeString();
});
