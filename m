From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 28 Nov 2014 13:11:40 +0100
Subject: [GIT PULL 2/5] Samsung 2nd round of cleanup for v3.19
In-Reply-To: <546F490F.1020601@kernel.org>
References: <546F490F.1020601@kernel.org>
Message-ID: <201411281311.40717.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 November 2014, Kukjin Kim wrote:
> The following changes since commit 13cfa6c4f7facfc690ba9e99ec382c151fddaced:
> 
>   ARM: EXYNOS: Fix CPU idle clock down after CPU off (2014-10-21
> 00:06:22 +0900)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-cleanup-2
> 
> for you to fetch changes up to 9c50b2a98cf0ca70480b70a4490a87177519094c:
> 
>   ARM: EXYNOS: Remove unused static iomapping (2014-11-13 11:42:59 +0900)
> 
> ----------------------------------------------------------------
> Samsung 2nd cleanup for v3.19
> 
> - remove unused static iomapping for exynos SoCs
>   : remove unused static iomapping from exynos4/5_iodesc table,
>     and related macros from mach/map.h and plat/map-s5p.h.

Nice cleanup!

Applied to next/cleanup, thanks!

	Arnd
