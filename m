From: robh@kernel.org (Rob Herring)
Date: Mon, 10 Sep 2018 13:13:17 -0500
Subject: [PATCH v5 11/14] dt-bindings/interrupt-controller: add
 documentation for Marvell SEI controller
In-Reply-To: <20180830073535.10710-12-miquel.raynal@bootlin.com>
References: <20180830073535.10710-1-miquel.raynal@bootlin.com>
 <20180830073535.10710-12-miquel.raynal@bootlin.com>
Message-ID: <20180910181317.GA5738@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 30 Aug 2018 09:35:32 +0200, Miquel Raynal wrote:
> Describe the System Error Interrupt (SEI) controller. It aggregates two
> types of interrupts, wired and MSIs from respectively the AP and the
> CPs, into a single SPI interrupt.
> 
> Suggested-by: Haim Boot <hayim@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../interrupt-controller/marvell,sei.txt      | 36 +++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,sei.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
