From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 5 Oct 2012 08:16:32 +0000
Subject: [PATCH 04/12] video: exynos: warnings in exynos_dp_core.c
In-Reply-To: <002001cda2cf$b0b69c60$1223d520$%han@samsung.com>
References: <1348868177-21205-1-git-send-email-arnd@arndb.de>
 <1348868177-21205-5-git-send-email-arnd@arndb.de>
 <002001cda2cf$b0b69c60$1223d520$%han@samsung.com>
Message-ID: <201210050816.33122.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 05 October 2012, Jingoo Han wrote:
> This problem was fixed. So, this patch is not necessary.
> 
> As you mentioned, this problem was introduced by d5c0eed01
> "video: exynos_dp: adjust voltage swing and pre-emphasis
> during Link Training".
> 
> However, this problem was resolved by e75478b "video: exynos_dp:
> replace link_status with link_align to check channel equalization".
> 
> The patch was merged to 'fbdev-next', and will be merged to
> '3.7-rc1', soon. Thank you.

Ok, thanks for letting know. I'll drop my patch then.

	Arnd
