From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 18 Mar 2014 16:07:42 +0100
Subject: [GIT PULL] Samsung non-critical fixes for v3.15
In-Reply-To: <5327CB4C.9070905@samsung.com>
References: <5327CB4C.9070905@samsung.com>
Message-ID: <201403181607.42503.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 18 March 2014, Kukjin Kim wrote:
> The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:
> 
>    Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)
> 
> are available in the git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
> tags/samsung-fixes
> 
> for you to fetch changes up to baf64abc468c7583592f67197ae23fa31414b4db:
> 
>    ARM: S3C64XX: mach-crag6410-module.c is not modular (2014-02-16 
> 02:05:44 +0900)
> 
> ----------------------------------------------------------------
> Samsung non-critical fixes for v3.15
> - fix typo CONFIG_CPU_S3C2443 in Kconfig
> - fix G3D regulator on because of entering low power mode
>    for exynos5250-arndale
> - fix CONFIG_USB_EHCI_EXYNOS for exynos_defconfig
> - fix initcall of mach-crag6410-module.c

Pulled into next/fixes-non-critical, thanks!

	Arnd
