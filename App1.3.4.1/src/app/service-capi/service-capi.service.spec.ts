import { TestBed } from '@angular/core/testing';

import { ServiceCapiService } from './service-capi.service';

describe('ServiceCapiService', () => {
  let service: ServiceCapiService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ServiceCapiService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
