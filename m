From: tony@atomide.com (Tony Lindgren)
Date: Sat, 15 Sep 2012 11:10:58 -0700
Subject: [PATCH 17/24] ARM: OMAP: use __iomem pointers for MMIO
In-Reply-To: <1347658492-11608-18-git-send-email-arnd@arndb.de>
References: <1347658492-11608-1-git-send-email-arnd@arndb.de>
 <1347658492-11608-18-git-send-email-arnd@arndb.de>
Message-ID: <20120915181057.GH4521@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [120914 14:36]:
> ARM is moving to stricter checks on readl/write functions,
> so we need to use the correct types everywhere.
> 
> Cc: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/plat-omap/include/plat/hardware.h |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/include/plat/hardware.h b/arch/arm/plat-omap/include/plat/hardware.h
> index ddbde38..2518f6c 100644
> --- a/arch/arm/plat-omap/include/plat/hardware.h
> +++ b/arch/arm/plat-omap/include/plat/hardware.h

With my patches, this is now all omap1 specific and
moved to arch/arm/mach-omap1/include/mach/hardware.h.
It's probably easiest to just update this patch on
top of the hardware.h changes I've done.

Regards,

Tony
