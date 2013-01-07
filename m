From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 07 Jan 2013 15:33:40 -0800
Subject: [GIT PULL] Samsung fixes-2 for v3.8
Message-ID: <081701cded2f$6dcf9960$496ecc20$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Here is Samsung-fixes-2 for v3.8.
Most of them are EXYNOS5440 fixes which are for changing uart console, cpu
id (typo)  and silent complaining gpio error in kernel boot.

If any problems, please kindly let me know.

Thanks and a very happy new year.

- Kukjin

The following changes since commit a49f0d1ea3ec94fc7cf33a7c36a16343b74bd565:

  Linux 3.8-rc1 (2012-12-21 17:19:00 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.8-samsung-fixes-2

for you to fetch changes up to 61bcbc2af8be4cafb5723d4bd306053b70f52a7a:

  ARM: EXYNOS: skip the clock initialization for exynos5440 (2013-01-05
08:32:55 -0800)

----------------------------------------------------------------
Kukjin Kim (5):
      ARM: SAMSUNG: fix the cpu id for EXYNOS5440
      ARM: dts: use uart port0 for console on exynos5440-ssdk5440
      ARM: dts: use uart port1 for console on exynos4210-smdkv310
      ARM: EXYNOS: enable PINCTRL for EXYNOS5440
      ARM: EXYNOS: skip the clock initialization for exynos5440

Sean Paul (1):
      ARM: EXYNOS: Revise HDMI resource size

 arch/arm/boot/dts/exynos4210-smdkv310.dts |    2 +-
 arch/arm/boot/dts/exynos5250.dtsi         |    2 +-
 arch/arm/boot/dts/exynos5440-ssdk5440.dts |    2 +-
 arch/arm/mach-exynos/Kconfig              |    2 ++
 arch/arm/mach-exynos/common.c             |    7 +++++++
 arch/arm/plat-samsung/include/plat/cpu.h  |    2 +-
 6 files changed, 13 insertions(+), 4 deletions(-)
