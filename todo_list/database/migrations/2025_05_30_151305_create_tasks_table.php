<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    
    public function up(): void
    {
        Schema::create('tasks', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('user_id'); // relasi ke tabel users
            $table->string('title');
            $table->date('due_date'); // hanya tanggal, bukan datetime
            $table->boolean('is_done')->default(false);
            $table->boolean('is_important')->default(false);
            $table->text('description')->nullable();
            $table->timestamp('completed_at')->nullable();
            $table->timestamps();

            
            $table->foreign('user_id')->references('id')->on('users')->onDelete('cascade');
        }); 
    }

  
    public function down(): void
    {
        Schema::dropIfExists('tasks');
    }
};
