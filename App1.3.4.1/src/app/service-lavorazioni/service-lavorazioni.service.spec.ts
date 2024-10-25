import { TestBed } from '@angular/core/testing';

import { ServiceLavorazioniService } from './service-lavorazioni.service';

describe('ServiceLavorazioniService', () => {
  let service: ServiceLavorazioniService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ServiceLavorazioniService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
