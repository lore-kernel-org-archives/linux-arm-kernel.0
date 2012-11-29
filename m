From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 29 Nov 2012 10:46:38 +0530
Subject: [PATCH V2 4/4] ARM: OMAP2+: Fix sparse warnings in timer.c
In-Reply-To: <1354140300-16825-5-git-send-email-jon-hunter@ti.com>
References: <1354140300-16825-1-git-send-email-jon-hunter@ti.com>
 <1354140300-16825-5-git-send-email-jon-hunter@ti.com>
Message-ID: <50B6EFB6.1060103@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 November 2012 03:35 AM, Jon Hunter wrote:
> From: Vaibhav Hiremath <hvaibhav@ti.com>
>
> Sparse generates the following warnings when compiling mach-omap2/timer.c.
>
>    CHECK   arch/arm/mach-omap2/timer.c
>    arch/arm/mach-omap2/timer.c:193:13: warning: symbol 'omap_dmtimer_init'
>    was not declared. Should it be static?
>    arch/arm/mach-omap2/timer.c:213:12: warning: symbol
>    'omap_dm_timer_get_errata' was not declared. Should it be static?
>
> Add static to function declaration to fix warnings.
>
> Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
