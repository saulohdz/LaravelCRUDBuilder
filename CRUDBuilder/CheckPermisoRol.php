<?php

namespace App\Traits;

use App\Models\User;
use Illuminate\Support\Facades\Auth;

trait CheckPermisoRol
{
    public function check_role_permiso($slug, $permiso)
    {
        if (Auth::user()->role_id == 1 || Auth::user()->role_id == 3) {
            try {
                $U = User::with(['REL_roles', 'REL_roles.REL_permisosRol', 'REL_roles.REL_permisosRol.REL_permisos'])->where('id', Auth::user()->id ?? -1)->first();
                return ($U->REL_roles->REL_permisosRol->where($permiso, 1)->first()->REL_permisos->where('slug', $slug)->first() ? true : false);
            } catch (\Exception $e) {
                return false;
            }
        } else if (Auth::user()->role_id == 2) {
            Auth::logout();
            return redirect('/');
        }
    }
}
