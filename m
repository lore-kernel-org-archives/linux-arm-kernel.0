From: santosh.shilimkar@ti.com (Santosh)
Date: Fri, 26 Aug 2011 20:03:03 +0530
Subject: [PATCH v14 REPOST 04/12] OMAP2+: dmtimer: convert to platform
	devices
In-Reply-To: <1310731501-13078-5-git-send-email-tarun.kanti@ti.com>
References: <1310731501-13078-1-git-send-email-tarun.kanti@ti.com>
	<1310731501-13078-5-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E57AE9F.7070907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 July 2011 05:34 PM, Tarun Kanti DebBarma wrote:
> Add routines to converts dmtimers to platform devices. The device data
> is obtained from hwmod database of respective platform and is registered
> to device model after successful binding to driver.
> In addition, capability attribute of each of the timers is added in
> hwmod database.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Signed-off-by: Thara Gopinath<thara@ti.com>
> Acked-by: Cousson, Benoit<b-cousson@ti.com>
> ---
>   arch/arm/mach-omap2/omap_hwmod_2420_data.c |   22 +++++
>   arch/arm/mach-omap2/omap_hwmod_2430_data.c |   22 +++++
>   arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |   27 ++++++
>   arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   21 +++++
>   arch/arm/mach-omap2/timer.c                |  136 ++++++++++++++++++++++++++++
>   arch/arm/plat-omap/include/plat/dmtimer.h  |   10 ++-
>   6 files changed, 237 insertions(+), 1 deletions(-)
>
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
