From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Sat, 22 Nov 2014 22:49:09 +0100
Subject: [PATCH v2 3/5] pinctrl: exynos: add exynos5410 SoC specific data
In-Reply-To: <1416687984-3546-4-git-send-email-afaerber@suse.de>
References: <1416687984-3546-1-git-send-email-afaerber@suse.de>
 <1416687984-3546-4-git-send-email-afaerber@suse.de>
Message-ID: <547104D5.4030803@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 22.11.2014 um 21:26 schrieb Andreas F?rber:
> From: Hakjoo Kim <ruppi.kim@hardkernel.com>
> 
> Add Samsung EXYNOS5410 SoC specific data to enable pinctrl
> support for all platforms based on EXYNOS5410.
> 
> Signed-off-by: Hakjoo Kim <ruppi.kim@hardkernel.com>
> [AF: Rebased onto Exynos5260]
> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> ---
> v1 -> v2:
> * Filled in Sob from Hakjoo Kim
> * Rebased (.svc, .{g,w}eint_{con,mask,pend} fields dropped)

Ugh, this patch is actually missing exactly this change! Stay tuned...

Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
