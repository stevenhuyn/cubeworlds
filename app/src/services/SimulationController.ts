import { Pane } from "tweakpane";

export class SimulationController extends EventTarget {
  static #instance: SimulationController;
  #params = {
    particles: 1000,
  };

  public get params() {
    return this.#params;
  }

  public static get Instance(): SimulationController {
    if (!this.#instance) {
      this.#instance = new SimulationController();
    }
    return this.#instance;
  }

  private constructor() {
    super();

    const pane = new Pane();

    pane.addInput(this.#params, "particles", { step: 1000, min: 1000, max: 15000 });
    pane.addButton({ title: "Apply" }).on("click", () => {
      this.dispatch(DispatchEvent.Destroy);
      setTimeout(() => {
        this.dispatch(DispatchEvent.Particles, this.#params.particles);
      }, 500);
    });
  }

  public init() {
    this.dispatch(DispatchEvent.Particles, this.#params.particles);
  }

  private dispatch(type: DispatchEventType, value?: unknown) {
    const event = new CustomEvent(type, { detail: value });
    this.dispatchEvent(event);
  }
}

export type DispatchEventType = (typeof DispatchEvent)[keyof typeof DispatchEvent];
export const DispatchEvent = {
  Particles: "cubeway-particles",
  Destroy: "cubeway-destroy",
};
