import { Component, OnInit, ViewChild } from '@angular/core';
import { MatTableDataSource } from '@angular/material/table';
import { ServiceCapiService } from './service-capi/service-capi.service';
import { ServiceLavorazioniService } from './service-lavorazioni/service-lavorazioni.service';
import { ServiceClientiService } from './service-clienti/service-clienti.service';
import { MatPaginator } from '@angular/material/paginator';



interface CapiData { //
  id: number;
  descrizione: string;
  versionID: number;
}

interface LavorazioniData { //
  id: number;
  descrizione: string;
  versionID: number;
}

interface ClientiData { //
  id: number;
  nome: string;
  cognome: string;
  indirizzo: string;
  telefono: string;
  giorno: number;
  mese: number;
  versionID: number;
}

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent implements OnInit {
  @ViewChild('paginatorCapi') paginatorCapi!: MatPaginator; //
  @ViewChild('paginatorLavorazioni') paginatorLavorazioni!: MatPaginator; //
  @ViewChild('paginatorClienti') paginatorClienti!: MatPaginator; //

  selectedTab = 0;

  changeTab(tabIndex: number) {
    this.selectedTab = tabIndex;
    this.updatePaginator(tabIndex);
  }
  
  updatePaginator(tabIndex: number) {
    switch (tabIndex) {
      case 0:
        this.dataSourceCapi.paginator = this.paginatorCapi;
        break;
      case 1:
        this.dataSourceLavorazioni.paginator = this.paginatorLavorazioni;
        break;
      case 2:
        this.dataSourceClienti.paginator = this.paginatorClienti;
        break;
      default:
        // Handle other tabs if needed
        break;
    }
  }
  
  constructor( //
    private serviceCapiService: ServiceCapiService, //
    private serviceLavorazioniService: ServiceLavorazioniService, //
    private serviceClientiService: ServiceClientiService //
  ) {}


  ngOnInit() { //
    this.serviceCapiService.getCapiData().subscribe((data: CapiData[]) => { //
      this.dataSourceCapi.data = data;
      this.dataSourceCapi.paginator = this.paginatorCapi;
    });

    this.serviceLavorazioniService.getLavorazioniData().subscribe((data: LavorazioniData[]) => { //
      this.dataSourceLavorazioni.data = data;
      this.dataSourceLavorazioni.paginator = this.paginatorLavorazioni;
    });

    this.serviceClientiService.getClientiData().subscribe((data: ClientiData[]) => { //
      this.dataSourceClienti.data = data;
      this.dataSourceClienti.paginator = this.paginatorClienti;
    });
    
  }

  dataSourceCapi = new MatTableDataSource<CapiData>([]); //
  dataSourceLavorazioni = new MatTableDataSource<LavorazioniData>([]); //
  dataSourceClienti = new MatTableDataSource<ClientiData>([]); //
}