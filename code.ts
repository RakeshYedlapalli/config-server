import { Routes } from '@angular/router';
import { PortalComponent } from './portal/portal.component';
import { AdministrationComponent } from './portal/administration/administration.component';
import { AssetComponent } from './asset/asset.component';
import { AssetHomeComponent } from './asset/home/asset-home.component';
import { HomeComponent } from './portal/home/home.component';
import { RoleGuard } from './shared/service/role-guard';

export const APP_ROUTES: Routes = [
  {
    path: 'investon/portal',
    component: PortalComponent,
    children: [
      {
        path: 'administration',
        component: AdministrationComponent,
        title: 'Administration',
        data: { breadcrumb: 'Administration' },
        canActivate: [RoleGuard],
      },
      {
        path: 'home',
        component: HomeComponent,
        title: 'Home',
        data: { breadcrumb: 'Home' },
        canActivate: [RoleGuard],
      },
      {
        path: '',
        redirectTo: 'home',
        pathMatch: 'full',
      },
    ],
  },
  {
    path: 'investon/asset',
    component: AssetComponent,
    children: [
      {
        path: 'home',
        component: AssetHomeComponent,
        title: 'Home',
        data: { breadcrumb: 'Home' },
      },
      {
        path: '',
        redirectTo: 'home',
        pathMatch: 'full',
      },
    ],
  },
  {
    path: '',
    redirectTo: 'investon/portal',
    pathMatch: 'full',
  },
  {
    path: '**',
    redirectTo: '/unauthorized',
  },
];







import { Injectable } from '@angular/core';
import { CanActivate, ActivatedRouteSnapshot, RouterStateSnapshot, Router, UrlTree } from '@angular/router';
import { Observable, map } from 'rxjs';
import { UserService } from 'src/app/core/service/feature/user.service';
import { ROLE_PAGE_ACCESS } from 'src/app/constants';

@Injectable({
  providedIn: 'root',
})
export class RoleGuard implements CanActivate {
  constructor(private router: Router, private userService: UserService) {}

  canActivate(route: ActivatedRouteSnapshot, state: RouterStateSnapshot): Observable<boolean | UrlTree> {
    return this.userService.userInfoData$.pipe(
      map((user) => {
        const role = user.roles[0].roleName;
        const roleAccess = ROLE_PAGE_ACCESS[role];

        if (roleAccess && roleAccess.pages.includes(state.url)) {
          return true;
        } else if (roleAccess) {
          return this.router.createUrlTree([roleAccess.defaultPage]);
        } else {
          return this.router.createUrlTree(['/unauthorized']);
        }
      })
    );
  }
}




