From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 May 2016 14:55:59 +0200
Subject: [PATCH 1/2] doc/devicetree: Add Aspeed VIC bindings
In-Reply-To: <1462797239-14765-2-git-send-email-joel@jms.id.au>
References: <1462797239-14765-1-git-send-email-joel@jms.id.au>
 <1462797239-14765-2-git-send-email-joel@jms.id.au>
Message-ID: <4320787.nfPydvIlpT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 May 2016 22:03:58 Joel Stanley wrote:
> +
> +- compatible : should be "aspeed,ast2400-vic".
> +
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.
> +- valid-sources : bitmask of valid irq sources
> +
> +Example:
> +
> + vic: interrupt-controller {
> +      compatible = "aspeed,ast2400-new-vic";
> 

The example doesn't match the binding regarding the compatible string,
otherwise looks ok to me.

	Arnd
