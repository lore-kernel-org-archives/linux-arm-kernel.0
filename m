From: kgene@kernel.org (Kukjin Kim)
Date: Mon, 12 Jan 2015 17:30:32 +0900
Subject: [GIT PULL] Samsung exynos7 updates for v3.20
Message-ID: <54B38628.5090902@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi again,

Please pull arm64 based exynos7 stuff for v3.20 and as you know I've
tried this in 3.19 but couldn't because of some dependencies like clk.
Now all of dependencies already resolved so this should be fine for v3.20.

If any problems, please kindly let me know.

Thanks,
Kukjin

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.20-next/dt-samsung-64

Abhilash Kesavan (2):
      arm64: dts: Add PMU DT node for exynos7 SoC
      arm64: dts: Add nodes for mmc, i2c, rtc, watchdog, adc on exynos7

Alim Akhtar (1):
      arm64: Enable ARMv8 based exynos7 SoC support

Naveen Krishna Ch (2):
      arm64: dts: Add initial device tree support for exynos7
      arm64: dts: Add initial pinctrl support to exynos7

 .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
 arch/arm64/Kconfig                                 |   17 +
 arch/arm64/boot/dts/Makefile                       |    1 +
 arch/arm64/boot/dts/exynos/Makefile                |    5 +
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |   84 +++
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    |  588
++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |  530
++++++++++++++++++
 7 files changed, 1226 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm64/boot/dts/exynos/Makefile
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-espresso.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7.dtsi
