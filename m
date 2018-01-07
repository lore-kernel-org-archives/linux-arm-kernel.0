From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  7 Jan 2018 12:36:23 +0100
Subject: [GIT PULL 1/4] ARM: dts: exynos: Stuff for v4.16, 2nd round
In-Reply-To: <20180107113625.15488-1-krzk@kernel.org>
References: <20180107113625.15488-1-krzk@kernel.org>
Message-ID: <20180107113625.15488-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 3be1ecf291df8191f5ea395d363acc8fa029b5fd:

  ARM: dts: exynos: Use lower case hex addresses in node unit addresses (2017-12-18 18:15:51 +0100)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.16-2

for you to fetch changes up to 5628a8ca14149ba4226e3bdce3a04c3b688435ad:

  ARM: dts: exynos: fix RTC interrupt for exynos5410 (2018-01-07 11:15:59 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for 4.16, part 2

1. Add SPDX license identifiers.
2. Properly fix DTC warning for PMU/RTC interrupts on Exynos5410.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: dts: exynos: fix RTC interrupt for exynos5410

Krzysztof Kozlowski (5):
      ARM: dts: exynos: Add SPDX license identifiers
      ARM: dts: s3c24xx: Add SPDX license identifiers
      ARM: dts: s3c64xx: Add SPDX license identifiers
      ARM: dts: s5pv210: Add SPDX license identifiers
      Revert "ARM: dts: exynos: Add missing interrupt-controller properties to Exynos5410 PMU"

 arch/arm/boot/dts/exynos3250-artik5-eval.dts       | 5 +----
 arch/arm/boot/dts/exynos3250-artik5.dtsi           | 5 +----
 arch/arm/boot/dts/exynos3250-monk.dts              | 5 +----
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi          | 7 ++-----
 arch/arm/boot/dts/exynos3250-rinato.dts            | 5 +----
 arch/arm/boot/dts/exynos3250.dtsi                  | 5 +----
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         | 6 +-----
 arch/arm/boot/dts/exynos4.dtsi                     | 5 +----
 arch/arm/boot/dts/exynos4210-origen.dts            | 7 ++-----
 arch/arm/boot/dts/exynos4210-pinctrl.dtsi          | 7 ++-----
 arch/arm/boot/dts/exynos4210-smdkv310.dts          | 7 ++-----
 arch/arm/boot/dts/exynos4210-trats.dts             | 7 ++-----
 arch/arm/boot/dts/exynos4210-universal_c210.dts    | 7 ++-----
 arch/arm/boot/dts/exynos4210.dtsi                  | 7 ++-----
 arch/arm/boot/dts/exynos4412-itop-elite.dts        | 5 +----
 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi    | 5 +----
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    | 5 +----
 arch/arm/boot/dts/exynos4412-odroidu3.dts          | 7 ++-----
 arch/arm/boot/dts/exynos4412-odroidx.dts           | 7 ++-----
 arch/arm/boot/dts/exynos4412-odroidx2.dts          | 7 ++-----
 arch/arm/boot/dts/exynos4412-origen.dts            | 7 ++-----
 arch/arm/boot/dts/exynos4412-pinctrl.dtsi          | 7 ++-----
 arch/arm/boot/dts/exynos4412-ppmu-common.dtsi      | 5 +----
 arch/arm/boot/dts/exynos4412-prime.dtsi            | 5 +----
 arch/arm/boot/dts/exynos4412-smdk4412.dts          | 7 ++-----
 arch/arm/boot/dts/exynos4412.dtsi                  | 7 ++-----
 arch/arm/boot/dts/exynos5.dtsi                     | 5 +----
 arch/arm/boot/dts/exynos5250-arndale.dts           | 5 +----
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          | 7 ++-----
 arch/arm/boot/dts/exynos5250-smdk5250.dts          | 5 +----
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      | 5 +----
 arch/arm/boot/dts/exynos5250-snow-rev5.dts         | 5 +----
 arch/arm/boot/dts/exynos5250-snow.dts              | 5 +----
 arch/arm/boot/dts/exynos5250-spring.dts            | 5 +----
 arch/arm/boot/dts/exynos5250.dtsi                  | 7 ++-----
 arch/arm/boot/dts/exynos5260-pinctrl.dtsi          | 7 ++-----
 arch/arm/boot/dts/exynos5260-xyref5260.dts         | 7 ++-----
 arch/arm/boot/dts/exynos5260.dtsi                  | 7 ++-----
 arch/arm/boot/dts/exynos5410-odroidxu.dts          | 5 +----
 arch/arm/boot/dts/exynos5410-pinctrl.dtsi          | 5 +----
 arch/arm/boot/dts/exynos5410-smdk5410.dts          | 7 ++-----
 arch/arm/boot/dts/exynos5410.dtsi                  | 9 +--------
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      | 7 ++-----
 arch/arm/boot/dts/exynos5420-cpus.dtsi             | 5 +----
 arch/arm/boot/dts/exynos5420-peach-pit.dts         | 5 +----
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          | 7 ++-----
 arch/arm/boot/dts/exynos5420-smdk5420.dts          | 7 ++-----
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi  | 6 +-----
 arch/arm/boot/dts/exynos5420-trip-points.dtsi      | 6 +-----
 arch/arm/boot/dts/exynos5420.dtsi                  | 5 +----
 arch/arm/boot/dts/exynos5422-cpus.dtsi             | 5 +----
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      | 7 ++-----
 arch/arm/boot/dts/exynos5422-odroidhc1.dts         | 7 ++-----
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi  | 7 ++-----
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 7 ++-----
 arch/arm/boot/dts/exynos5422-odroidxu3-lite.dts    | 7 ++-----
 arch/arm/boot/dts/exynos5422-odroidxu3.dts         | 7 ++-----
 arch/arm/boot/dts/exynos5422-odroidxu4.dts         | 7 ++-----
 arch/arm/boot/dts/exynos5440-sd5v1.dts             | 7 ++-----
 arch/arm/boot/dts/exynos5440-ssdk5440.dts          | 7 ++-----
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  | 6 +-----
 arch/arm/boot/dts/exynos5440-trip-points.dtsi      | 6 +-----
 arch/arm/boot/dts/exynos5440.dtsi                  | 7 ++-----
 arch/arm/boot/dts/exynos54xx-odroidxu-leds.dtsi    | 7 ++-----
 arch/arm/boot/dts/exynos54xx.dtsi                  | 5 +----
 arch/arm/boot/dts/s3c2416-pinctrl.dtsi             | 5 +----
 arch/arm/boot/dts/s3c2416-smdk2416.dts             | 5 +----
 arch/arm/boot/dts/s3c2416.dtsi                     | 5 +----
 arch/arm/boot/dts/s3c24xx.dtsi                     | 5 +----
 arch/arm/boot/dts/s3c6400.dtsi                     | 7 ++-----
 arch/arm/boot/dts/s3c6410-mini6410.dts             | 7 ++-----
 arch/arm/boot/dts/s3c6410-smdk6410.dts             | 7 ++-----
 arch/arm/boot/dts/s3c6410.dtsi                     | 7 ++-----
 arch/arm/boot/dts/s3c64xx-pinctrl.dtsi             | 5 +----
 arch/arm/boot/dts/s3c64xx.dtsi                     | 5 +----
 arch/arm/boot/dts/s5pv210-aquila.dts               | 5 +----
 arch/arm/boot/dts/s5pv210-goni.dts                 | 5 +----
 arch/arm/boot/dts/s5pv210-pinctrl.dtsi             | 5 +----
 arch/arm/boot/dts/s5pv210-smdkc110.dts             | 5 +----
 arch/arm/boot/dts/s5pv210-smdkv210.dts             | 5 +----
 arch/arm/boot/dts/s5pv210-torbreck.dts             | 5 +----
 arch/arm/boot/dts/s5pv210.dtsi                     | 7 ++-----
 82 files changed, 121 insertions(+), 376 deletions(-)
