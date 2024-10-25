import { TestBed } from '@angular/core/testing';

import { ServiceClientiService } from './service-clienti.service';

describe('ServiceClientiService', () => {
  let service: ServiceClientiService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ServiceClientiService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
