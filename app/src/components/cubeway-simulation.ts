import { LitElement, css, html } from "lit";
import { customElement } from "lit/decorators.js";
import init from "../../../cubeway/pkg/cubeway";

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
    init().then(() => {});
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
