From: robh@kernel.org (Rob Herring)
Date: Mon, 26 Jun 2017 13:04:14 -0500
Subject: [PATCH v5 1/6] dt-bindings: interrupt-controller: add DT binding
 for the Marvell GICP
In-Reply-To: <20170621132917.14187-2-thomas.petazzoni@free-electrons.com>
References: <20170621132917.14187-1-thomas.petazzoni@free-electrons.com>
 <20170621132917.14187-2-thomas.petazzoni@free-electrons.com>
Message-ID: <20170626180414.w6lc7oyalmc5ib74@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 03:29:12PM +0200, Thomas Petazzoni wrote:
> This commit adds the Device Tree binding documentation for the Marvell
> GICP, an extension to the GIC that allows to trigger GIC SPI interrupts
> using memory transactions. It is used by the ICU unit in the Marvell
> CP110 block to turn wired interrupts inside the CP into SPI interrupts
> at the GIC level in the AP.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../bindings/interrupt-controller/marvell,gicp.txt | 27 ++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,gicp.txt

Acked-by: Rob Herring <robh@kernel.org>
