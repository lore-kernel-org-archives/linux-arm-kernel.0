From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 7 Jul 2012 08:57:45 +0000
Subject: linux-next warning for arch/arm/mach-exynos/setup-usb-phy.c
Message-ID: <201207070857.45615.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch 7fb8d215706 "ARM: EXYNOS: Update HSOTG PHY clock setting for EXYNOS4X12"
in the exynos tree causes a new warning in exynos4_defconfig:

arch/arm/mach-exynos/setup-usb-phy.c: In function 'exynos4210_usb_phy_clkset':
arch/arm/mach-exynos/setup-usb-phy.c:83:97: error: 'phyclk' may be used uninitialized in this function [-Werror=uninitialized]

Please fix.

	Arnd
