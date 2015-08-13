From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 13 Aug 2015 09:11:55 +0900
Subject: [GIT PULL 2nd 1/4] Samsung defconfig updates for v4.3
Message-ID: <55CBE0CB.1060708@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-defconfig-1

for you to fetch changes up to c3e71f4b5f580b43e0eb3be18059c8844d8713e7:

  ARM: multi_v7_defconfig: Enable max77802 regulator (2015-08-12
08:15:02 +0900)

----------------------------------------------------------------
Samsung defconfig updates for v4.3

- for exynos_defconfig
  : enable SND_SOC_ODROIDX2 and SND_SIMPLE_CARD for
    Odroid-XU3 to use max98090 audio codec
  : enalbe SENSORS_NTC_THERMISTOR for Peach boards

- for multi_v7_defconfig:
  : remove SAMSUNG_USB2PHY and SAMSUNG_USB3PHY are not used now
  : enable SENSORS_NTC_THERMISTOR and EXYNOS_ADC for Peach boards
  : enable REGULATOR_MAX77802 for Peach boards

----------------------------------------------------------------
Anand Moon (1):
      ARM: exynos_defconfig: Enable CONFIG_SND_SOC_ODROIDX2 for Odroid-XU3

Javier Martinez Canillas (4):
      ARM: multi_v7_defconfig: Remove old Samsung USB PHY configs
      ARM: multi_v7_defconfig: Enable NTC Thermistors support
      ARM: exynos_defconfig: Enable NTC Thermistors support
      ARM: multi_v7_defconfig: Enable max77802 regulator

 arch/arm/configs/exynos_defconfig   | 3 +++
 arch/arm/configs/multi_v7_defconfig | 5 +++--
 2 files changed, 6 insertions(+), 2 deletions(-)
