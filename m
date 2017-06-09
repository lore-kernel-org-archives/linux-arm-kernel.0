From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri,  9 Jun 2017 18:42:47 +0200
Subject: [GIT PULL 2/4] ARM: dts: exynos: DT for v4.13
In-Reply-To: <20170609164249.1656-1-krzk@kernel.org>
References: <20170609164249.1656-1-krzk@kernel.org>
Message-ID: <20170609164249.1656-3-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.13

for you to fetch changes up to c92a4fb249bf98670543b4c41307e1e71942d513:

  ARM: dts: exynos: Use human-friendly symbols for GIC interrupt properties (2017-06-07 20:56:06 +0200)

----------------------------------------------------------------
Samsung DeviceTree update for v4.13:
1. Add HDMI CEC to Exynos5 SoCs.
2. Minor cleanups and readability improvements.

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      ARM: dts: exynos: Use human-friendly symbols for interrupt flags in board sources
      ARM: dts: exynos: Use human-friendly symbols for GIC interrupt properties

Marek Szyprowski (2):
      ARM: dts: exynos: Remove MFC reserved buffers
      ARM: dts: exynos: Add HDMI CEC device to Exynos5 SoC family

 arch/arm/boot/dts/exynos3250-monk.dts              |  6 +-
 arch/arm/boot/dts/exynos3250-rinato.dts            |  6 +-
 arch/arm/boot/dts/exynos4210-origen.dts            |  2 +-
 arch/arm/boot/dts/exynos4210-trats.dts             |  4 +-
 arch/arm/boot/dts/exynos4412-odroid-common.dtsi    |  6 +-
 arch/arm/boot/dts/exynos4412-odroidx.dts           |  2 +-
 arch/arm/boot/dts/exynos4412-trats2.dts            |  8 +-
 arch/arm/boot/dts/exynos5.dtsi                     | 84 ++++++++++----------
 arch/arm/boot/dts/exynos5250-arndale.dts           |  1 -
 arch/arm/boot/dts/exynos5250-pinctrl.dtsi          |  7 ++
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |  1 -
 arch/arm/boot/dts/exynos5250-snow-common.dtsi      |  4 +
 arch/arm/boot/dts/exynos5250-spring.dts            |  1 -
 arch/arm/boot/dts/exynos5250.dtsi                  | 21 ++++-
 arch/arm/boot/dts/exynos5420-arndale-octa.dts      |  1 -
 arch/arm/boot/dts/exynos5420-peach-pit.dts         |  5 +-
 arch/arm/boot/dts/exynos5420-pinctrl.dtsi          |  7 ++
 arch/arm/boot/dts/exynos5420-smdk5420.dts          |  1 -
 arch/arm/boot/dts/exynos5420.dtsi                  | 89 +++++++++++++---------
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi  |  2 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  5 +-
 arch/arm/boot/dts/exynos5440.dtsi                  |  2 +-
 arch/arm/boot/dts/exynos5800-peach-pi.dts          |  5 +-
 23 files changed, 155 insertions(+), 115 deletions(-)
