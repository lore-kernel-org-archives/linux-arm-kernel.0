From: olof@lixom.net (Olof Johansson)
Date: Fri, 30 May 2014 21:44:26 -0700
Subject: [GIT PULL 3/5] Samsung Exynos updates for 3.16
In-Reply-To: <5388E32B.3010908@samsung.com>
References: <5388E32B.3010908@samsung.com>
Message-ID: <20140531044426.GE21917@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 31, 2014 at 04:59:39AM +0900, Kukjin Kim wrote:
> The following changes since commit fced6dee29f6fb143fe16ea90331176ff77e6120:
> 
>   Merge branch 'v3.16-next/cleanup-samsung' into
> v3.16-next/platform-exynos (2014-05-31 02:36:49 +0900)
> 
> are available in the git repository at:
> 
> 

> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> tags/samsung-exynos
> 
> for you to fetch changes up to 9dfa92ec4033c348aae6bafc1881e07229fabaa6:
> 
>   ARM: EXYNOS: Enable multi-platform build support (2014-05-31
> 02:43:51 +0900)
> 
> ----------------------------------------------------------------
> Samsung Exynos updates for 3.16
> 
> - add new SoCs support
>   : exynos3250, 5260, 5410 and 5800
> 
> - enable multi-platform on exynos
>   : consolidate exynos related Kconfig entries
> 
> Note that this requires tags/samsung-cleanup and tags/samsung-clk-2
> because of mostly migration exynos specific macros into mach-exynos
> and exynos related Kconfig entries.
> 
> One more merge conflict happens in arch/arm/Kconfig for ARCH_EXYNOS
> due to SRAM stuff, even though tried to sort them out. Since just
> resolving it would be better I think, please remove ARCH_EXYNOS in
> arch/arm/Kconfig when merge conflict happens.

There was also a conflict in firmware.c due to fixes, please double-check my
resolution of it.


-Olof
