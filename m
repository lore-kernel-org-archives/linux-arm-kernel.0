From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 03 May 2012 16:43:25 +0530
Subject: [PATCH 1/8] gpio/omap: remove virtual_irq_start variable
In-Reply-To: <1335536018-16004-2-git-send-email-tarun.kanti@ti.com>
References: <1335536018-16004-1-git-send-email-tarun.kanti@ti.com>
 <1335536018-16004-2-git-send-email-tarun.kanti@ti.com>
Message-ID: <4FA26855.3010005@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 27 April 2012 07:43 PM, Tarun Kanti DebBarma wrote:
> This cleanup got missed while implementing following:
> 25db711 gpio/omap: Fix IRQ handling for SPARSE_IRQ
> 384ebe1 gpio/omap: Add DT support to GPIO driver
> 
> Cc: Kevin Hilman <khilman@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Cousson, Benoit <b-cousson@ti.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> ---
>  arch/arm/mach-omap1/gpio15xx.c         |    2 --
>  arch/arm/mach-omap1/gpio16xx.c         |    5 -----
>  arch/arm/mach-omap1/gpio7xx.c          |    7 -------
>  arch/arm/mach-omap2/gpio.c             |    1 -
>  arch/arm/plat-omap/include/plat/gpio.h |    1 -
>  5 files changed, 0 insertions(+), 16 deletions(-)
> 
Looks good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
