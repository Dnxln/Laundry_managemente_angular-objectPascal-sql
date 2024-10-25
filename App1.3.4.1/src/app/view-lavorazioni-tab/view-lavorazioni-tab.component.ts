import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { ServiceLavorazioniService } from '../service-lavorazioni/service-lavorazioni.service';
import { MatPaginator } from '@angular/material/paginator';
import { MatSelectChange } from '@angular/material/select';
import { HttpErrorResponse } from '@angular/common/http';
import { MatRowSelectionService } from '../directives/row-selection/mat-row-selection.service';


export interface LavorazioniData {
  id: number;
  descrizione: string;
  versionID: number;
  [key: string]: number | string; 
}


type Lavorazione = {
  id: number,
  descrizione: string,
  versionID: number
}


interface ID {
  value: number; 
  viewValue: string; 
}


@Component({
  selector: 'app-view-lavorazioni-tab',
  templateUrl: './view-lavorazioni-tab.component.html',
  styleUrls: ['./view-lavorazioni-tab.component.css'],
  providers: [MatRowSelectionService]
})


export class ViewLavorazioniTabComponent implements OnInit{
  @ViewChild('paginatorLavorazioni') paginatorLavorazioni!: MatPaginator;


  IDs: ID[] = [];
  selectedID: number | null = -1;
  selectedIDForm: number | null = null;
  _selectedRow: Lavorazione | null = null;
  _hasLavorazione: boolean = false;
  selectedLavorazione: Lavorazione | null = null;
  selectedRowIndex: number | undefined;


  constructor(
    private serviceLavorazioniService: ServiceLavorazioniService,
    private selection: MatRowSelectionService<Lavorazione> 
  ) {}


  ngOnInit() {
    this.serviceLavorazioniService.getLavorazioniData().subscribe((data: LavorazioniData[]) => {
      this.dataSourceLavorazioni.data = data;
      this.dataSourceLavorazioni.paginator = this.paginatorLavorazioni;
      this.IDs = data.map((item: LavorazioniData) => ({ value: item.id, viewValue: item.id.toString() }));
      this.IDs.unshift({ value: -1, viewValue: 'Nan' });
    }); 
    
    this.serviceLavorazioniService.getLavorazioniDataByID(this.selectedID !== null ? this.selectedID : -1).subscribe((data: LavorazioniData[]) => {
      this.dataSourceLavorazioniID.data = data;
      this.IDs.unshift({ value: -1, viewValue: 'Nan' });
    });

    document.addEventListener('keydown', (event) => {
      this.handleKeyPress(event);
    });

    this.selection.getSelectedRow().subscribe({
      next: (value: Lavorazione | null) => {
        this.selectedLavorazione = value;
        this.selectedIDForm = value?.id ?? null;
        if (value) {
          this.serviceLavorazioniService.getLavorazioniDataByID(value.id).subscribe({
            next: (value) => {
              this.dataSourceLavorazioniID.data = value;
            },
          });
        }
      }
    });
  }

  dataSourceLavorazioni = new MatTableDataSource<LavorazioniData>([]);
  dataSourceLavorazioniID = new MatTableDataSource<LavorazioniData>([]);
  displayedColumnsLavorazioni: string[] = ['id', 'descrizione', 'versionID'];
  public descrizioneLavorazione: string | null = null;

  handleKeyPress(event: KeyboardEvent) {
    if (event.key === 'Enter') {
      this.filtraLavorazioniTable();
    }
  }

  filtraLavorazioniTable() {
    const filterPrefix = 'f:';
    const categorySeparator = '#';
  
    this.dataSourceLavorazioni.filterPredicate = (data: LavorazioniData, filter: string) => {
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
  
    if (this.descrizioneLavorazione) {
      this.dataSourceLavorazioni.filter = this.descrizioneLavorazione.toLowerCase();
    } else {
      this.descrizioneLavorazione = null;
      this.dataSourceLavorazioni.filter = '';
    }
  }
 
  customFilterPredicate(data: LavorazioniData, filter: string): boolean {
    const selectedID = parseInt(filter, 10);
    return data.id === selectedID;
  }


  handleSelectionChange(event: MatSelectChange) {
    const selectedID = event.value !== null ? event.value : -1; 
    this.selectedID = selectedID;
    this.selectedIDForm = selectedID; 
  
    if (selectedID !== -1) {
      this.serviceLavorazioniService.getLavorazioniDataByID(selectedID).subscribe({
        next: (data) => {
          this.dataSourceLavorazioniID.data = data;
          this._selectedRow = data.length > 0 ? data[0] : null;
          this.selection.select(this._selectedRow as Lavorazione); 
        },
        error: (error: HttpErrorResponse) => {
          this.dataSourceLavorazioniID.data = [];
          console.log(error);
        }
      });
    } else {
      this.dataSourceLavorazioniID.data = [];
      this._selectedRow = null;
      this.selection.select(null as unknown as Lavorazione);
    }
  }

  isRowSelected(row: Lavorazione): boolean {
    return row === this._selectedRow;
  }

  public getSelectedRowData(serviceLavorazioniService: ServiceLavorazioniService, selection: MatRowSelectionService<Lavorazione>): Promise<LavorazioniData | null> {
    return new Promise<LavorazioniData | null>((resolve, reject) => {
      selection.getSelectedRow().subscribe(async (row) => {
        if (row) {
          try {
            const data = await serviceLavorazioniService.getLavorazioniDataByID(row.id).toPromise();
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


  handleRowClick(row: Lavorazione, index: number): void {
    if (this.selectedRowIndex === index) {
      this.selectedRowIndex = -1;
    } else {
      this.selectedRowIndex = index;
    }
  }

  isRowSelectedByIndex(index: number): boolean {
    return this.selectedRowIndex === index;
  } 

}