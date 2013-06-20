From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 22:53:46 +0200
Subject: [GIT PULL 06/10] Samsung non-DT EXYNOS for v3.11
In-Reply-To: <51C0BC62.3000605@samsung.com>
References: <51C0BC62.3000605@samsung.com>
Message-ID: <201306202253.47163.arnd@arndb.de>
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
> tags/remove-nondt-exynos-3
> 
> for you to fetch changes up to 564d06b1266ee62c9b47eab8305755e5ff6e38d5:
> 
>    ARM: EXYNOS: Remove remaining dead code after non-DT support removal 
> (2013-06-19 01:37:53 +0900)
> 
> ----------------------------------------------------------------
> cleanup and removing dead code for only support DT for exynos
> - remove board file for exynos
> - remove legacy files which are not used anymore
> - decouple ARCH_EXYNOS from PLAT_S5P

Pulled into next/soc, thanks!

	Arnd
