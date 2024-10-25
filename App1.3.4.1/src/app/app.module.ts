import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { BrowserAnimationsModule } from '@angular/platform-browser/animations';


import { HttpClientModule } from '@angular/common/http';


import { MatTabsModule } from '@angular/material/tabs';

import { MatTableModule } from '@angular/material/table';
import { MatPaginatorModule } from '@angular/material/paginator';

import {MatInputModule} from '@angular/material/input';
import {MatFormFieldModule} from '@angular/material/form-field';
import {FormsModule, ReactiveFormsModule} from '@angular/forms';


import {MatIconModule} from '@angular/material/icon';
import {MatDividerModule} from '@angular/material/divider';
import {MatButtonModule} from '@angular/material/button';
import { ViewCapiTabComponent } from './view-capi-tab/view-capi-tab.component';
import { ViewLavorazioniTabComponent } from './view-lavorazioni-tab/view-lavorazioni-tab.component';
import { ViewClientiTabComponent } from './view-clienti-tab/view-clienti-tab.component';



import {NgFor} from '@angular/common';
import {MatSelectModule} from '@angular/material/select';
import { MatRowSelectionDirective } from './directives/row-selection/mat-row-selection.directive';
import { MatTableSelectionDirective } from './directives/row-selection/mat-table-selection.directive';


import {MatDialog, MAT_DIALOG_DATA, MatDialogRef, MatDialogModule} from '@angular/material/dialog';
import {NgIf} from '@angular/common';








@NgModule({
  declarations: [
    AppComponent,
    ViewCapiTabComponent,
    ViewLavorazioniTabComponent,
    ViewClientiTabComponent,
    MatRowSelectionDirective,
    MatTableSelectionDirective
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    BrowserAnimationsModule,
    MatTabsModule,
    MatTableModule,
    MatPaginatorModule,
    HttpClientModule,
    FormsModule, 
    ReactiveFormsModule,
    MatButtonModule, 
    MatDividerModule, 
    MatIconModule,
    MatFormFieldModule, 
    MatSelectModule, 
    NgFor, 
    MatInputModule,
    MatFormFieldModule,
    MatInputModule,
    FormsModule,
    MatButtonModule,
    NgIf,
    MatDialogModule,
    MatFormFieldModule,
    MatInputModule,
    FormsModule,
    MatButtonModule,
    NgIf,
    MatDialogModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
