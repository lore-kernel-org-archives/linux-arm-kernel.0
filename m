From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Mon, 17 Dec 2012 10:04:32 +0100
Subject: [PATCH 2/2] ARM: OMAP2+: Drop plat/cpu.h for omap2plus
In-Reply-To: <20121216200317.24238.63954.stgit@muffinssi.local>
References: <20121216200236.24238.38151.stgit@muffinssi.local>
 <20121216200317.24238.63954.stgit@muffinssi.local>
Message-ID: <1555457.YNrhJNmIOs@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

Thanks for the patch.

On Sunday 16 December 2012 12:03:17 Tony Lindgren wrote:
> The cpu_is_omap macros are now local to arch/arm/mach-omap2
> in soc.h and plat/cpu.h can finally be dropped for omap2+.
> Thanks everybody for help with fixing the drivers.
> 
> Note that we can now also remove the unused plat/cpu.h from
> smartreflex.c and isp.c as they will cause compile errors
> with ARCH_MULTIPLATFORM enabled.
> 
> Cc: Jean Pihet <jean.pihet@newoldbits.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Mauro Carvalho Chehab <mchehab@redhat.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

For the OMAP3 ISP part,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm/mach-omap2/drm.c             |    1 -
>  arch/arm/mach-omap2/dss-common.c      |    3 +--
>  arch/arm/mach-omap2/prm2xxx.c         |    3 +--
>  arch/arm/mach-omap2/prm3xxx.c         |    3 +--
>  arch/arm/plat-omap/include/plat/cpu.h |    4 ----
>  drivers/media/platform/omap3isp/isp.c |    2 --
>  drivers/power/avs/smartreflex.c       |    2 --
>  7 files changed, 3 insertions(+), 15 deletions(-)

-- 
Regards,

Laurent Pinchart
