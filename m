From: robh@kernel.org (Rob Herring)
Date: Wed, 23 Nov 2016 17:01:03 -0600
Subject: [PATCH v4 1/2] Documentation: dt: reset: Add TI SCI reset binding
In-Reply-To: <20161121213052.8684-2-afd@ti.com>
References: <20161121213052.8684-1-afd@ti.com>
 <20161121213052.8684-2-afd@ti.com>
Message-ID: <20161123230103.lnffpkby43uzcb6k@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 21, 2016 at 03:30:51PM -0600, Andrew F. Davis wrote:
> Add TI SCI reset controller binding. This describes the DT binding
> details for a reset controller node providing reset management services
> to hardware blocks (reset consumers) using the Texas Instrument's System
> Control Interface (TI SCI) protocol to communicate to a system controller
> block present on the SoC.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> [s-anna at ti.com: revise the binding format]
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> ---
>  .../devicetree/bindings/reset/ti,sci-reset.txt     | 66 ++++++++++++++++++++++
>  MAINTAINERS                                        |  2 +
>  include/dt-bindings/reset/k2g.h                    | 22 ++++++++
>  3 files changed, 90 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/ti,sci-reset.txt
>  create mode 100644 include/dt-bindings/reset/k2g.h

Acked-by: Rob Herring <robh@kernel.org>
