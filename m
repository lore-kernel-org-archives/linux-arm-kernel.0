From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 21:51:34 +0200
Subject: [GIT PULL 02/10] Samsung EXYNOS arch for v3.11
In-Reply-To: <51C0BC3F.2060002@samsung.com>
References: <51C0BC3F.2060002@samsung.com>
Message-ID: <201306202151.34934.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 June 2013, Kukjin Kim wrote:
> The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:
> 
>    Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> tags/exynos-arch-2
> 
> for you to fetch changes up to b5f3c75a75d31039c6de3ab38d074b43c60462f7:
> 
>    ARM: EXYNOS: call scu_enable() only in case of cortex-A9 processor 
> (2013-06-19 03:41:38 +0900)
> 
> ----------------------------------------------------------------
> arch/arm/mach-exynos update
> - enable XHCI on exynos5
> - enable Pinctrl on exynos4 and exynos5
> - calling scu_enable() is only available on Cortex-A9

Pulled into next/soc, thanks!

	ARnd
