import { NgModule } from '@angular/core';
import { ServerModule } from '@angular/platform-server';

import { AppModule } from './app.module';
import { HomepageComponent } from './homepage/homepage.component'; // Import HomepageComponent
import { OrderComponent } from './order/order.component';
import { HeaderComponent } from './header/header.component';
import { FooterComponent } from './footer/footer.component';
import { OrderConfirmComponent } from './order-confirm/order-confirm.component';
import { LoginComponent } from './login/login.component';
import { RegisterComponent } from './register/register.component';
import { DetailProductComponent } from './detail-product/detail-product.component';
@NgModule({
  imports: [
    AppModule,
    ServerModule,
  ],
  bootstrap: [
    HomepageComponent,
    // OrderComponent,
    // OrderConfirmComponent,
    // LoginComponent,
    // RegisterComponent
    // DetailProductComponent
    
  ], // Bootstrap HomepageComponent
})
export class AppServerModule {}
