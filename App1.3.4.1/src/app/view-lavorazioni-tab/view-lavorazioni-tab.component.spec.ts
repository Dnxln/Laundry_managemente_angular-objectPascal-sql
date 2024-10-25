import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewLavorazioniTabComponent } from './view-lavorazioni-tab.component';

describe('ViewLavorazioniTabComponent', () => {
  let component: ViewLavorazioniTabComponent;
  let fixture: ComponentFixture<ViewLavorazioniTabComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ViewLavorazioniTabComponent]
    });
    fixture = TestBed.createComponent(ViewLavorazioniTabComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
