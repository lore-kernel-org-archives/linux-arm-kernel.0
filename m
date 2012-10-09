From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 08 Oct 2012 20:54:40 -0600
Subject: [PATCH 3/6] ARM: bcm476x: Add sched clock
In-Reply-To: <20121007015406.809888002@gmail.com>
References: <20121007015300.828366635@gmail.com>
 <20121007015406.809888002@gmail.com>
Message-ID: <507391F0.8070609@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/06/2012 07:53 PM, Domenico Andreoli wrote:
> Sched clock implementation based on the BCM476x's free runner counter.

> Index: b/Documentation/devicetree/bindings/timer/brcm,bcm476x-sched-clock.txt
> ===================================================================
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/brcm,bcm476x-sched-clock.txt
> @@ -0,0 +1,18 @@
> +BCM476x Sched clock
> +
> +The BCM476x provides a 63-bit free running counter driven by a separate
> +32KHz clock line.

Is "sched clock" really the name of the HW module in the Broadcom
documentation (well, assuming you have any access to that). DT names
should derived from HW manuals/... where possible.
