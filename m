From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 04 Mar 2013 14:54:18 +0100
Subject: [PATCH] ARM: S5PV210: Fix PL330 DMA controller clkdev entries
In-Reply-To: <008001ce18d8$451527e0$cf3f77a0$%kim@samsung.com>
References: <1362227906-13921-1-git-send-email-s.nawrocki@samsung.com>
 <51321326.6050800@gmail.com> <008001ce18d8$451527e0$cf3f77a0$%kim@samsung.com>
Message-ID: <5134A78A.9050709@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/04/2013 02:00 PM, Kukjin Kim wrote:
> Looks good to me, applied into -fixes.
> 
> Sylwester, why did you want to re-send this patch?

Only to add

Tested-by: Lonsn <lonsn2005@gmail.com>
Cc: stable at vger.kernel.org # 3.7

tags, and any other in case someone else tests the patch.

I think we would need this fix for stable 3.7 as well.

Thanks for applying it.

Regards,
Sylwester
