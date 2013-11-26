From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 26 Nov 2013 10:14:06 -0500
Subject: [RESEND PATCH v2 1/3] irqchip: irq-dove: Add PMU interrupt
 controller.
In-Reply-To: <1383820531-4387-1-git-send-email-andrew@lunn.ch>
References: <1383820531-4387-1-git-send-email-andrew@lunn.ch>
Message-ID: <20131126151406.GK2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 07, 2013 at 11:35:29AM +0100, Andrew Lunn wrote:
> Dove has a Power Management Unit with its own interrupt
> controller. This is chained on the main interrupt controller.  Add a
> driver, making use of generic chip where possible.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> 
> cc: devicetree at vger.kernel.org
> cc: pawel.moll at arm.com
> cc: mark.rutland at arm.com
> cc: swarren at wwwdotorg.org
> cc: ian.campbell at citrix.com
> ---
>  .../interrupt-controller/marvell,dove-pmu-intc.txt |  17 +++
>  drivers/irqchip/Makefile                           |   1 +
>  drivers/irqchip/irq-dove.c                         | 126 +++++++++++++++++++++
>  3 files changed, 144 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/marvell,dove-pmu-intc.txt
>  create mode 100644 drivers/irqchip/irq-dove.c

Applied to mvebu/irqchip for tglx once it's stewed in -next for a bit.

thx,

Jason.
