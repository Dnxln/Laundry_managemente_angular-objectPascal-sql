import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable } from 'rxjs';
import { ClientiData } from '../view-clienti-tab/view-clienti-tab.component';


@Injectable({
  providedIn: 'root'
})
export class ServiceClientiService {

  constructor(private http: HttpClient) { }

  getClientiData(): Observable<ClientiData[]> {
    //return this.http.get('./assets/clienti.json');
    return this.http.get<ClientiData[]>('http://127.0.0.1:8888/clienti');
  }

  getClientiDataByID(id: number): Observable<ClientiData[]> {
    //return this.http.get('./assets/clienti.json');
    return this.http.get<ClientiData[]>(`http://127.0.0.1:8888/clienti?id=${id}`);
  }
  
  
}
