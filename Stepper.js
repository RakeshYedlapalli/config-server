To convert your Vue.js stepper code to Angular (version 16 with a component-based approach), here’s how it would look:

Angular Component Code (stepper.component.ts)

import { Component } from '@angular/core';

@Component({
  selector: 'app-stepper',
  templateUrl: './stepper.component.html',
  styleUrls: ['./stepper.component.scss']
})
export class StepperComponent {
  steps = ['Step 1', 'Step 2', 'Step 3']; // Add your step names here
  selectedStepIndex = 0;

  selectStep(index: number): void {
    this.selectedStepIndex = index;
  }
}

HTML Template (stepper.component.html)

<div class="title-container">
  <div class="group">
    <div
      *ngFor="let step of steps; let index = index"
      class="space"
    >
      <div
        class="circle"
        [class.selected]="selectedStepIndex === index"
        (click)="selectStep(index)"
      >
        {{ step }}
      </div>
      <hr *ngIf="index < steps.length - 1" />
    </div>
  </div>
</div>

SCSS Styles (stepper.component.scss)

.title-container {
  margin: 0 auto;
  group {
    padding-left: 3%;
  }
}

.space {
  display: flex;
  width: 30%;
  justify-content: flex-start;
  align-items: center;

  hr {
    border-top: 1px dashed #d2d2d2;
    color: #d2d2d2;
    height: 4px;
    flex: 1;

    &:last-child {
      display: none;
    }
  }
}

.circle {
  display: inline-flex;
  justify-content: center;
  align-items: center;
  padding: 0 5px;
  width: 8rem;
  height: 8rem;
  border-radius: 50%;
  font-size: 15px;
  color: #3f4d5e;
  line-height: 1.3rem;
  text-align: center;
  background: #d8dbdb;
  cursor: pointer;

  &.selected {
    color: #fff;
    background: #3f4d5e;
  }
}

Key Notes:
	1.	Structure Mapping:
	•	The v-for loop in Vue is replaced by Angular’s *ngFor.
	•	The :class in Vue is replaced by [class.selected] in Angular.
	•	The Vue event binding (@click) is replaced by Angular’s (click).
	2.	Two-Way Data Binding:
	•	Vue uses v-model or direct bindings, while Angular uses [(ngModel)] or [property] + (event) pattern. Here, we use a property (selectedStepIndex) to track the current step.
	3.	Scoped Styles:
	•	Vue’s scoped styles are equivalent to Angular’s encapsulated styles via ViewEncapsulation (default behavior in Angular).

You can integrate this into your Angular project and adjust the steps or styles as per your requirements.
