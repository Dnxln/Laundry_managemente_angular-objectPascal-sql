import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { ServiceClientiService } from '../service-clienti/service-clienti.service';
import { MatPaginator } from '@angular/material/paginator';
import { MatSelectChange } from '@angular/material/select';
import { HttpErrorResponse } from '@angular/common/http';
import { MatRowSelectionService } from '../directives/row-selection/mat-row-selection.service';


export interface ClientiData {
  id: number;
  nome: string;
  cognome: string;
  indirizzo: string;
  telefono: string;
  giorno: number;
  mese: number;
  versionID: number;
  [key: string]: number | string;
}


type Cliente = {
  id: number;
  nome: string;
  cognome: string;
  indirizzo: string;
  telefono: string;
  giorno: string;
  mese: string;
  versionID: number;
}


interface ID {
  value: number; 
  viewValue: string; 
}


@Component({
  selector: 'app-view-clienti-tab',
  templateUrl: './view-clienti-tab.component.html',
  styleUrls: ['./view-clienti-tab.component.css'],
  providers: [MatRowSelectionService]
})


export class ViewClientiTabComponent implements OnInit{
  @ViewChild('paginatorClienti') paginatorClienti!: MatPaginator;

  IDs: ID[] = [];
  selectedID: number | null = -1;
  selectedIDForm: number | null = null;
  _selectedRow: Cliente | null = null;
  _hasCliente: boolean = false;
  selectedCliente: Cliente | null = null;
  selectedRowIndex: number | undefined;


  constructor(
    private serviceClientiService: ServiceClientiService,
    private selection: MatRowSelectionService<Cliente> 

  ) {}


  ngOnInit() {
    this.serviceClientiService.getClientiData().subscribe((data: ClientiData[]) => {
      this.dataSourceClienti.data = data;
      this.dataSourceClienti.paginator = this.paginatorClienti;
      this.IDs = data.map((item: ClientiData) => ({ value: item.id, viewValue: item.id.toString() }));
      this.IDs.unshift({ value: -1, viewValue: 'Nan' });
    });

    this.serviceClientiService.getClientiDataByID(this.selectedID !== null ? this.selectedID : -1).subscribe((data: ClientiData[]) => {
      this.dataSourceClientiID.data = data;
      this.IDs.unshift({ value: -1, viewValue: 'Nan' });
    });
    
    document.addEventListener('keydown', (event) => {
      this.handleKeyPress(event);
    });

    this.selection.getSelectedRow().subscribe({
      next: (value: Cliente | null) => {
        this.selectedCliente = value;
        this.selectedIDForm = value?.id ?? null;
        if (value) {
          this.serviceClientiService.getClientiDataByID(value.id).subscribe({
            next: (value) => {
              this.dataSourceClientiID.data = value;
            },
          });
        }
      }
    });
  }

  dataSourceClienti = new MatTableDataSource<ClientiData>([]);
  dataSourceClientiID = new MatTableDataSource<ClientiData>([]);
  displayedColumnsClienti: string[] = ['id', 'nome', 'cognome', 'indirizzo', 'telefono', 'giorno', 'mese', 'versionID'];
  public nome: string | null = null;

  handleKeyPress(event: KeyboardEvent) {
    if (event.key === 'Enter') {
      console.log("ao")
      this.filtraClientiTable();
    }
  }

  filtraClientiTable() {
    const filterPrefix = 'f:';
    const categorySeparator = '#';
  
    this.dataSourceClienti.filterPredicate = (data: ClientiData, filter: string) => {
      let filterParts = filter.startsWith(filterPrefix) ? filter.substring(filterPrefix.length).split(categorySeparator) : [];
      let category = filterParts[0]?.toLowerCase();
      let value = filterParts[1]?.toLowerCase();
      let inputValue = filter.trim().toLowerCase();
      let properties = ['id', 'nome', 'cognome', 'indirizzo', 'telefono', 'giorno', 'mese', 'versionID'];
  
      if (category && value) {
        let categoryValue = data[category]?.toString().toLowerCase();
        return categoryValue === value;
      }
  
      return properties.some(prop => data[prop]?.toString().toLowerCase() === inputValue);
    };
  
    if (this.nome) {
      this.dataSourceClienti.filter = this.nome.toLowerCase();
    } else {
      this.nome = null;
      this.dataSourceClienti.filter = '';
    }
  }
  
  customFilterPredicate(data: ClientiData, filter: string): boolean {
    const selectedID = parseInt(filter, 10);
    return data.id === selectedID;
  }


  handleSelectionChange(event: MatSelectChange) {
    const selectedID = event.value !== null ? event.value : -1; 
    this.selectedID = selectedID;
    this.selectedIDForm = selectedID; 
  
    if (selectedID !== -1) {
      this.serviceClientiService.getClientiDataByID(selectedID).subscribe({
        next: (data) => {
          this.dataSourceClientiID.data = data;
          this._selectedRow = data.length > 0 ? {
            ...data[0],
            giorno: data[0].giorno.toString(),
            mese: data[0].mese.toString()
          } as unknown as Cliente : null;          
          this.selection.select(this._selectedRow as Cliente); 
        },
        error: (error: HttpErrorResponse) => {
          this.dataSourceClientiID.data = [];
          console.log(error);
        }
      });
    } else {
      this.dataSourceClientiID.data = [];
      this._selectedRow = null;
      this.selection.select(null as unknown as Cliente);
    }
  }

  isRowSelected(row: Cliente): boolean {
    return row === this._selectedRow;
  }

  public getSelectedRowData(serviceClientiService: ServiceClientiService, selection: MatRowSelectionService<Cliente>): Promise<ClientiData | null> {
    return new Promise<ClientiData | null>((resolve, reject) => {
      selection.getSelectedRow().subscribe(async (row) => {
        if (row) {
          try {
            const data = await serviceClientiService.getClientiDataByID(row.id).toPromise();
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

  handleRowClick(row: Cliente, index: number): void {
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
