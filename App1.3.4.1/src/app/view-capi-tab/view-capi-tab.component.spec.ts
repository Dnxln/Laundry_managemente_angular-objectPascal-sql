import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewCapiTabComponent } from './view-capi-tab.component';

describe('ViewCapiTabComponent', () => {
  let component: ViewCapiTabComponent;
  let fixture: ComponentFixture<ViewCapiTabComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ViewCapiTabComponent]
    });
    fixture = TestBed.createComponent(ViewCapiTabComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
