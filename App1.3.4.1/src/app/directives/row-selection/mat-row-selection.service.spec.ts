import { TestBed } from '@angular/core/testing';

import { MatRowSelectionService } from './mat-row-selection.service';

describe('MatRowSelectionService', () => {
  let service: MatRowSelectionService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(MatRowSelectionService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
