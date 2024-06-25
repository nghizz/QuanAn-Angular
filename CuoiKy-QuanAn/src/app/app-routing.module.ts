import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { HomepageComponent } from './homepage/homepage.component';
import { OrderComponent } from './order/order.component';
import { OrderConfirmComponent } from './order-confirm/order-confirm.component';

const routes: Routes = [
  { path: '', component: HomepageComponent }, // Default route for homepage
  { path: 'order', component: OrderComponent }, // Route for order page
  { path: 'order-confirm', component: OrderConfirmComponent }, // Route for order confirmation page
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
