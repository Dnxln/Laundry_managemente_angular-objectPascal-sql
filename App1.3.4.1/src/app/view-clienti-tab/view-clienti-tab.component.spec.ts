import { ComponentFixture, TestBed } from '@angular/core/testing';

import { ViewClientiTabComponent } from './view-clienti-tab.component';

describe('ViewClientiTabComponent', () => {
  let component: ViewClientiTabComponent;
  let fixture: ComponentFixture<ViewClientiTabComponent>;

  beforeEach(() => {
    TestBed.configureTestingModule({
      declarations: [ViewClientiTabComponent]
    });
    fixture = TestBed.createComponent(ViewClientiTabComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
