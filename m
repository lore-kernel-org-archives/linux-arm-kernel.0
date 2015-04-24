From: santosh.shilimkar@oracle.com (santosh shilimkar)
Date: Fri, 24 Apr 2015 08:29:28 -0700
Subject: [PATCH] gpio: omap: Fix regression for MPUIO interrupts
In-Reply-To: <1429833257-28188-1-git-send-email-tony@atomide.com>
References: <1429833257-28188-1-git-send-email-tony@atomide.com>
Message-ID: <553A6158.1050705@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/23/2015 4:54 PM, Tony Lindgren wrote:
> At some point with all the GPIO clean-up we've broken the
> MPUIO interrupts. Those are just a little bit different from
> the GPIO interrupts, so we can fix it up just by setting
> different irqchip functions for it. And then we can just
> remove all old code trying to do the same.
>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Javier Martinez Canillas <javier@dowhile0.org>
> Cc: Grygorii Strashko <grygorii.strashko@linaro.org>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
