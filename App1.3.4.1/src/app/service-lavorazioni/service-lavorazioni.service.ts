import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { LavorazioniData } from '../view-lavorazioni-tab/view-lavorazioni-tab.component';


@Injectable({
  providedIn: 'root'
})
export class ServiceLavorazioniService {

  constructor(private http: HttpClient) { }

  getLavorazioniData(): Observable<LavorazioniData[]> {
    //return this.http.get('./assets/lavorazioni.json');
    return this.http.get<LavorazioniData[]>('http://127.0.0.1:8888/lavorazioni');
  }

  getLavorazioniDataByID(id: number): Observable<LavorazioniData[]> {
    //return this.http.get('./assets/lavorazioni.json');
    return this.http.get<LavorazioniData[]>(`http://127.0.0.1:8888/lavorazioni?id=${id}`);
  }
  
}