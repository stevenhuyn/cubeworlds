import { Pane } from "tweakpane";

export class SimulationController extends EventTarget {
  static #instance: SimulationController;

  public static get Instance(): SimulationController {
    if (!this.#instance) {
      this.#instance = new SimulationController();
    }
    return this.#instance;
  }

  private constructor() {
    super();
    const PARAMS = {
      particles: 1,
    };

    const pane = new Pane();

    pane.addInput(PARAMS, "particles", { step: 1, min: 1, max: 1000 });
    pane.addButton({ title: "Apply" }).on("click", () => {
      console.log("apply");
      this.dispatch(DispatchEvent.Particles, PARAMS.particles);
    });
  }

  private dispatch(type: DispatchEventType, value?: unknown) {
    console.log("dispatching");
    const event = new CustomEvent(type, { detail: value });
    this.dispatchEvent(event);
  }
}

export type DispatchEventType = (typeof DispatchEvent)[keyof typeof DispatchEvent];
export const DispatchEvent = {
  Particles: "cubeway-particles",
};
