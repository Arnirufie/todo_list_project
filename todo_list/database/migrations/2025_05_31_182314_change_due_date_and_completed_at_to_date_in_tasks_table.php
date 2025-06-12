<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    
    public function up(): void
    {
       Schema::table('tasks', function (Blueprint $table) {
            // Ubah tipe kolom dari datetime ke date
            $table->date('due_date')->change();
            $table->date('completed_at')->nullable()->change();
        });
    }

    public function down(): void
    {
        Schema::table('tasks', function (Blueprint $table) {
            // Kembalikan tipe kolom ke datetime jika rollback
            $table->dateTime('due_date')->change();
            $table->dateTime('completed_at')->nullable()->change();
        });
    }
};
