From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 28 Mar 2011 18:53:12 -0500
Subject: [PATCH] EP93xx: Remove ep93xx_gpio_dbg_show function
In-Reply-To: <4D9113AA.20404@bluewatersys.com>
References: <4D9113AA.20404@bluewatersys.com>
Message-ID: <0D753D10438DA54287A00B027084269764D19A811F@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, March 28, 2011 4:03 PM, Ryan Mallon wrote:
>
> Hartley pointed out that the patch I posted to remove the irq internals
> fiddling from ep93xx_gpio_dbg_show does not function as expected. It
> will print [interrupt] beside all pins which are capable of being
> interrupts, not just those which are currently configured as interrupts.
>
> The best solution is just to remove the custom ep93xx gpio debugfs
> function all together. The generic gpiolib one is good enough.
>
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>

Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>
