import { Directive, HostListener, Input, Renderer2 } from '@angular/core';
import { MatRowSelectionService } from './mat-row-selection.service';

@Directive({
  selector: 'tr[mat-row][mat-row-selection]'
})
export class MatRowSelectionDirective<T> {
  @Input() rowSelection!: T;

  constructor(
    private selection: MatRowSelectionService<T>,
    private renderer: Renderer2
  ) { }

  @HostListener('click', ['$event.target'])
  onClick(target: HTMLElement) {
    // Controlla se l'evento è stato generato dal pulsante di selezione della riga
    if (target.classList.contains('mat-selection-cbox')) {
      return;
    }

    this.selection.select(this.rowSelection);
  }
}
