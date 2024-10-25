import { Directive } from '@angular/core';

@Directive({
  selector: 'table[mat-table][mat-table-selection]',
})
export class MatTableSelectionDirective<T> {

}