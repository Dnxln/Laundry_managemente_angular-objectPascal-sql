import { Injectable } from '@angular/core';
import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Observable } from 'rxjs';
import { CapiData } from '../view-capi-tab/view-capi-tab.component';


@Injectable({
  providedIn: 'root'
})
export class ServiceCapiService {

  constructor(private http: HttpClient) { }

  getCapiData(): Observable<CapiData[]> {
    //return this.http.get('./assets/capi.json');
    return this.http.get<CapiData[]>('http://127.0.0.1:8888/capi');
  }
  getCapiDataByID(id: number): Observable<CapiData[]> {
    //return this.http.get('./assets/capi.json');
    return this.http.get<CapiData[]>(`http://127.0.0.1:8888/capi?ID=${id}`);
  }

  insertCapo(descrizione: string): Observable<CapiData[]> {
    const url = 'http://localhost:8888/capi';
    const body = { "descrizione": descrizione };
  
    const headers = new HttpHeaders({
      'Content-Type': 'application/json'
    });
    
    console.log("descrizione: "+descrizione);
    return this.http.post<CapiData[]>(url, body, { headers });
  }
  
  updateCapo(id: number, descrizione: string, versionID: number): Observable<CapiData[]> {
    const url = 'http://localhost:8888/capi';
    const body = {
      "id": id,
      "descrizione": descrizione,
      "versionID": versionID
    };
  
    const headers = new HttpHeaders({
      'Content-Type': 'application/json'
    });
    console.log("id: "+id);
    console.log("descrizione: "+descrizione);
    console.log("versionid: "+versionID);
    return this.http.put<CapiData[]>(url, body, { headers });
  }  

  deleteCapo(id: number, versionID: number): Observable<CapiData[]> {
    //return this.http.get('./assets/capi.json');
    console.log("id: "+id);
    console.log("versionid: "+versionID);
    return this.http.delete<CapiData[]>(`http://localhost:8888/capi?id=${id}&versionID=${versionID}`, {headers: {'Content-Type': 'application/json'}}); 
  } 
}