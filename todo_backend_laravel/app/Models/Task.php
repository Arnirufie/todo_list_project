<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

class Task extends Model
{
    protected $fillable = [
        'title',
        'due_date',
        'is_done',
        'is_important',
        'description',
        'completed_at',
        'user_id',
    ];

    protected $casts = [
        'due_date' => 'date',
        'completed_at' => 'datetime',
        'is_done' => 'boolean',
        'is_important' => 'boolean',
    ];

    /**
     * Set format input untuk due_date: simpan sebagai Y-m-d
     */
    public function setDueDateAttribute($value)
    {
        $this->attributes['due_date'] = Carbon::parse($value)->format('Y-m-d');
    }

    public function getDueDateAttribute($value)
    {
        return Carbon::parse($value)->format('Y-m-d');
    }

    public function getCompletedAtAttribute($value)
    {
        return $value
            ? Carbon::parse($value)->format('Y-m-d')
            : null;
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
