import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { ServiceCapiService } from '../service-capi/service-capi.service';
import { MatPaginator } from '@angular/material/paginator';
import { MatSelectChange } from '@angular/material/select';
import { HttpErrorResponse } from '@angular/common/http';
import { MatRowSelectionService } from '../directives/row-selection/mat-row-selection.service';

import {Inject} from '@angular/core';
import {MatDialog, MAT_DIALOG_DATA, MatDialogRef, MatDialogModule} from '@angular/material/dialog';
import {NgIf} from '@angular/common';
import {MatButtonModule} from '@angular/material/button';
import {FormsModule} from '@angular/forms';
import {MatInputModule} from '@angular/material/input';
import {MatFormFieldModule} from '@angular/material/form-field';




export interface CapiData {
  id: number;
  descrizione: string;
  versionID: number;
  [key: string]: number | string; 
}


type Capo = {
  id: number,
  descrizione: string,
  versionID: number
}


interface ID {
  value: number; 
  viewValue: string;
}


@Component({
  selector: 'app-view-capi-tab',
  templateUrl: './view-capi-tab.component.html',
  styleUrls: ['./view-capi-tab.component.css'],
  providers: [MatRowSelectionService],
})


export class ViewCapiTabComponent implements OnInit {
  @ViewChild('paginatorCapi') paginatorCapi!: MatPaginator;


  IDs: ID[] = [];
  selectedID: number | null = -1;
  selectedIDForm: number | null = null;
  _selectedRow: Capo | null = null;
  _hasCapo: boolean = false;
  selectedCapo: Capo | null = null;
  selectedRowIndex: number | undefined;
  selectedModifica: boolean = false;
  selectedInserisci: boolean = false;

  descrizione:string = '';


  constructor(
    private serviceCapiService: ServiceCapiService,
    private selection: MatRowSelectionService<Capo>,
    public dialog: MatDialog,
  ) {}
  

  ngOnInit() {
    this.serviceCapiService.getCapiData().subscribe((data: CapiData[]) => {
      this.dataSourceCapi.data = data;
      this.dataSourceCapi.paginator = this.paginatorCapi;
      this.IDs = data.map((item: CapiData) => ({ value: item.id, viewValue: item.id.toString() }));
      this.IDs.unshift({ value: -1, viewValue: 'Nan' });
    });
    
    this.serviceCapiService.getCapiDataByID(this.selectedID !== null ? this.selectedID : -1).subscribe((data: CapiData[]) => {
      this.dataSourceCapiID.data = data;
      this.IDs.unshift({ value: -1, viewValue: 'Nan' });
    });
    
    document.addEventListener('keydown', (event) => {
      this.handleKeyPress(event);
    });

    this.selection.getSelectedRow().subscribe({
      next: (value: Capo | null) => {
        this.selectedCapo = value;
        this.selectedIDForm = value?.id ?? null;
        if (value) {
          this.serviceCapiService.getCapiDataByID(value.id).subscribe({
            next: (value) => {
              this.dataSourceCapiID.data = value;
            },
          });
        }
      }
    });
  }
  
  dataSourceCapi = new MatTableDataSource<CapiData>([]);
  dataSourceCapiID = new MatTableDataSource<CapiData>([]);
  displayedColumnsCapi: string[] = ['descrizione'];
  displayedColumnsCapiID: string[] = ['id', 'descrizione', 'versionID'];

  public descrizioneCapo: string | null = null;
  
  handleKeyPress(event: KeyboardEvent) {
    if (event.key === 'Enter') {
      this.filtraCapiTable();
    }
  }

  filtraCapiTable() {
    const filterPrefix = 'f:';
    const categorySeparator = '#';

    this.dataSourceCapi.filterPredicate = (data: CapiData, filter: string) => {
      let filterParts = filter.startsWith(filterPrefix) ? filter.substring(filterPrefix.length).split(categorySeparator) : [];
      let category = filterParts[0]?.toLowerCase();
      let value = filterParts[1]?.toLowerCase();
      let inputValue = filter.trim().toLowerCase();
      let properties = ['id', 'descrizione', 'versionID'];

      if (category && value) {
        let categoryValue = data[category]?.toString().toLowerCase();
        return categoryValue === value;
      }
      return properties.some(prop => data[prop]?.toString().toLowerCase() === inputValue);
    };

    if (this.descrizioneCapo) {
      this.dataSourceCapi.filter = this.descrizioneCapo.toLowerCase();
    } else {
      this.descrizioneCapo = null;
      this.dataSourceCapi.filter = '';
    }
  }

  customFilterPredicate(data: CapiData, filter: string): boolean {
    const selectedID = parseInt(filter, 10);
    return data.id === selectedID;
  }


  handleSelectionChange(event: MatSelectChange) {
    const selectedID = event.value !== null ? event.value : -1; 
    this.selectedID = selectedID;
    this.selectedIDForm = selectedID; 
  
    if (selectedID !== -1) {
      this.serviceCapiService.getCapiDataByID(selectedID).subscribe({
        next: (data) => {
          this.dataSourceCapiID.data = data;
          this._selectedRow = data.length > 0 ? data[0] : null;
          this.selection.select(this._selectedRow as Capo); 
        },
        error: (error: HttpErrorResponse) => {
          this.dataSourceCapiID.data = [];
          console.log(error);
        }
      });
    } else {
      this.dataSourceCapiID.data = [];
      this._selectedRow = null;
      this.selection.select(null as unknown as Capo);
    }
  }

  isRowSelected(row: Capo): boolean {
    return row === this._selectedRow;
  }
  
  public getSelectedRowData(serviceCapiService: ServiceCapiService, selection: MatRowSelectionService<Capo>): Promise<CapiData | null> {
    return new Promise<CapiData | null>((resolve, reject) => {
      selection.getSelectedRow().subscribe(async (row) => {
        if (row) {
          try {
            const data = await serviceCapiService.getCapiDataByID(row.id).toPromise();
            const selectedData = data?.[0] ?? null;
            resolve(selectedData);
          } catch (error) {
            reject(error);
          }
        } else {
          resolve(null);
        }
      });
    });
  }


  handleRowClick(row: Capo, index: number): void {
    if (this.selectedRowIndex === index) {
      this.selectedRowIndex = -1;
      this.selectedModifica = false;
    } else {
      this.selectedRowIndex = index;
    }
  }

  isRowSelectedByIndex(index: number): boolean {
    return this.selectedRowIndex === index;
  } 


  apriInserisci() {
    if(this.selectedModifica || this.selectedInserisci){
      this.selectedInserisci = false;  
    }
    else{
      this.selectedInserisci = true;
    }
  }
  inserisciCapo(descrizione: string) {
    if(descrizione !== ''){
      this.serviceCapiService.insertCapo(descrizione).subscribe({});
      this.serviceCapiService.getCapiData().subscribe({});
    }
  }
  handleKeyPress3(event: KeyboardEvent) {
    if (event.key === 'Enter') {
      this.inserisciCapo(this.descrizione!);
    }
  }


  apriModifica() {
    if(this.selectedModifica || this.selectedInserisci){
      this.selectedModifica = false;  
    }
    else{
      this.selectedModifica = true;
    }
  }
  modificaCapo(capo: Capo) {
    const ID = capo.id;
    const versionID = capo.versionID;
    const descrizione = this.descrizione;

    if (ID !== -1 && versionID !== -1 && descrizione !== '') {
      this.serviceCapiService.updateCapo(ID, descrizione, versionID).subscribe({});
      this.serviceCapiService.getCapiData().subscribe({});
    }
  }
  handleKeyPress2(event: KeyboardEvent) {
    if (event.key === 'Enter') {
      this.modificaCapo(this.selectedCapo!);
    }
    
  }


  eliminaCapo(capo: Capo) {
    const ID = capo.id;
    const versionID = capo.versionID
  
    if (ID !== -1 && versionID !== -1) {
      this.serviceCapiService.deleteCapo(ID, versionID).subscribe({});
      this.serviceCapiService.getCapiData().subscribe({});
    }
  }

}