From: robh@kernel.org (Rob Herring)
Date: Thu, 22 Jun 2017 16:18:36 -0500
Subject: [PATCH v5 2/6] dt-bindings: interrupt-controller: add DT binding
 for the Marvell ICU
In-Reply-To: <20170621132917.14187-3-thomas.petazzoni@free-electrons.com>
References: <20170621132917.14187-1-thomas.petazzoni@free-electrons.com>
 <20170621132917.14187-3-thomas.petazzoni@free-electrons.com>
Message-ID: <20170622211836.qhk3whwaq4pecaw4@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 03:29:13PM +0200, Thomas Petazzoni wrote:
> This commit adds the Device Tree binding documentation for the Marvell
> ICU interrupt controller, which collects wired interrupts from the
> devices located into the CP110 hardware block of Marvell Armada 7K/8K,
> and converts them into SPI interrupts in the GIC located in the AP
> hardware block, using the GICP extension.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  .../bindings/interrupt-controller/marvell,icu.txt  | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,icu.txt

Acked-by: Rob Herring <robh@kernel.org>
