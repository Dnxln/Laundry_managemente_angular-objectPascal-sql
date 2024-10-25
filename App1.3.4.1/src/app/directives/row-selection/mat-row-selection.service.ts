import { Injectable } from '@angular/core';
import { BehaviorSubject, Observable } from 'rxjs';

@Injectable()
export class MatRowSelectionService<T> 
{
  private $selectedRow: BehaviorSubject<T | null>;

  constructor() 
  { 
    this.$selectedRow = new BehaviorSubject<T | null>(null);
  }
  
  public select(row: T) : void
  {
    if(this.$selectedRow.getValue() === row)
    {
      this.$selectedRow.next(null); // deseleziona
    } 
    else 
    {
      this.$selectedRow.next(row); // seleziona
    }
  }

  public getSelectedRow() : Observable<T | null>
  {
    return this.$selectedRow.asObservable();
  } 
}
