From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Jun 2013 22:53:27 +0200
Subject: [GIT PULL 09/10] Samsung exynos_defconfig for v3.11
In-Reply-To: <51C0BC7B.908@samsung.com>
References: <51C0BC7B.908@samsung.com>
Message-ID: <201306202253.27477.arnd@arndb.de>
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
> tags/samsung-defconfig-1
> 
> for you to fetch changes up to 85964af2cd7950c875048e3089c0bf7e2a89ed5b:
> 
>    ARM: exynos_defconfig: Enable GPIO buttons and RTC drivers 
> (2013-06-19 00:35:14 +0900)
> 
> ----------------------------------------------------------------
> update exynos_defconfig
> - enable GPIO buttons and RTC drivers
> 
> ----------------------------------------------------------------
> Tushar Behera (1):
>        ARM: exynos_defconfig: Enable GPIO buttons and RTC drivers
> 
>   arch/arm/configs/exynos_defconfig | 3 +++
>   1 file changed, 3 insertions(+)
> 

Pulled into next/soc, thanks!

	Arnd
