From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 30 Jan 2013 11:24:32 +0530
Subject: [PATCH] ARM: OMAP2+: Fix selection of clockevent timer when using
 device-tree
In-Reply-To: <1359490991-17688-1-git-send-email-jon-hunter@ti.com>
References: <1359490991-17688-1-git-send-email-jon-hunter@ti.com>
Message-ID: <5108B598.6080401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 January 2013 01:53 AM, Jon Hunter wrote:
> Commit 9725f44 (ARM: OMAP: Add DT support for timer driver) added
> device-tree support for selecting a clockevent timer by property.
> However, the code is currently ignoring the property passed and
> selecting the first available timer found. Hence, for the OMAP3 beagle
> board timer-12 is not being selected as expected. Fix this problem
> by ensuring the timer property is passed to omap_get_timer_dt().
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
