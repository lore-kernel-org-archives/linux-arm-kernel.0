From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 22 Jun 2016 18:53:57 +0000
Subject: [PATCH v3 0/2] irqchip: Support Aspeed IRQ controller
In-Reply-To: <1463064193-2178-1-git-send-email-joel@jms.id.au>
References: <1462802317-27086-1-git-send-email-joel@jms.id.au>
 <1463064193-2178-1-git-send-email-joel@jms.id.au>
Message-ID: <20160622185357.GE9922@io.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Joel, Ben,

On Fri, May 13, 2016 at 12:13:11AM +0930, Joel Stanley wrote:
> Hello All,
> 
> This adds support for the IRQ controller found in the Aspeed ast2400 and
> ast2500 BMC SoCs.
> 
> It's been tested on the ast2400 in an OpenPower Palmetto system, and on the
> ast2500-edk developer kit.
> 
> V2 has a fix for the compatible string in the device tree bindings.
> 
> V3 drops the valid-sources bitmasks and adds a unit address to the example in
> the bindings
> 
> Cheers,
> 
> Joel
> 
> Benjamin Herrenschmidt (1):
>   irqchip: Add irq controller for Aspeed
> 
> Joel Stanley (1):
>   doc/devicetree: Add Aspeed VIC bindings
> 
>  .../interrupt-controller/aspeed,ast2400-vic.txt    |  22 ++
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-aspeed-vic.c                   | 230 +++++++++++++++++++++
>  3 files changed, 253 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/aspeed,ast2400-vic.txt
>  create mode 100644 drivers/irqchip/irq-aspeed-vic.c

Series applied to irqchip/aspeed.  I'll only rebase it if you tell me
to. :-)

Should be in -next the next time it gets built.

thx,

Jason.
