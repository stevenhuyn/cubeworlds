import { LitElement, css, html } from "lit";
import { customElement } from "lit/decorators.js";
import init, { run } from "../../../cubeway/pkg/cubeway";
import { DispatchEvent, SimulationController } from "../services/SimulationController";

/**
 * An example element.
 *
 * @slot - This element has a slot
 * @csspart button - The button
 */
@customElement("cubeway-simulation")
export class CubewaySimulation extends LitElement {
  connectedCallback(): void {
    super.connectedCallback();
    SimulationController.Instance.addEventListener(DispatchEvent.Particles, (e: Event) => {
      this.requestUpdate();
      const detail = (<CustomEvent>e).detail;
      run(detail as number);
    });

    init().then(() => {
      run(100);
    });
  }

  render() {
    return html` <slot></slot> `;
  }

  static styles = css`
    :host {
      max-width: 1280px;
      margin: 0 auto;
      padding: 2rem;
      text-align: center;
    }
  `;
}

declare global {
  interface HTMLElementTagNameMap {
    "cubeway-simulation": CubewaySimulation;
  }
}
