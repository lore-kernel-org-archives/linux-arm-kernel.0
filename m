From: kgene@kernel.org (Kukjin Kim)
Date: Fri, 14 Aug 2015 03:53:51 +0900
Subject: [GIT PULL v2 5/5] Samsung defconfig updates for v4.3
In-Reply-To: <55CCE517.2070003@kernel.org>
References: <55CCE517.2070003@kernel.org>
Message-ID: <55CCE7BF.2070407@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d770e558e21961ad6cfdf0ff7df0eb5d7d4f0754:

  Linux 4.2-rc1 (2015-07-05 11:01:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-defconfig-new

for you to fetch changes up to 2b347c6494cbc6bfdc81b5201b8aa34afb2c3500:

  ARM: exynos_defconfig: Enable cpufreq-dt driver (2015-08-12 08:17:31
+0900)

----------------------------------------------------------------
Samsung defconfig updates for v4.3

- for exynos_defconfig
  : enable SND_SOC_ODROIDX2 and SND_SIMPLE_CARD for
    Odroid-XU3 to use max98090 audio codec
  : enalbe SENSORS_NTC_THERMISTOR for Peach boards
  : enable cpufreq-dt driver with ONDEMAND governor
    for Exynos SoCs 3250, 4210, 4212, 4412 and 5250

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

Krzysztof Kozlowski (1):
      ARM: exynos_defconfig: Enable cpufreq-dt driver

 arch/arm/configs/exynos_defconfig   | 5 +++++
 arch/arm/configs/multi_v7_defconfig | 5 +++--
 2 files changed, 8 insertions(+), 2 deletions(-)
