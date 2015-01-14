From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 15 Jan 2015 00:07:16 +0900
Subject: [GIT PULL RE-SEND] Samsung exynos7 updates for v3.20
In-Reply-To: <54B38628.5090902@kernel.org>
References: <54B38628.5090902@kernel.org>
Message-ID: <54B68624.8000706@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sorry, I'm resending this pull-request because of missing signed-tag.

Please pull. If any problems, please let me know.

Thanks,
Kukjin

The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:

  Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-dt-64

for you to fetch changes up to 6f56eef1f9aba3747c811780a4768618167d5c97:

  arm64: Enable ARMv8 based exynos7 SoC support (2014-12-23 00:19:08 +0900)

----------------------------------------------------------------
Samsung arch/arm64 DT updates for v3.19

- to support ARMv8 based exynos7 SoC
  : add initial device tree for pinctrl, PMU, mmc, i2c, rtc,
    watchdog, and adc nodes for exynos7 SoC and exynos7 based
    espresso board.

----------------------------------------------------------------
Abhilash Kesavan (2):
      arm64: dts: Add PMU DT node for exynos7 SoC
      arm64: dts: Add nodes for mmc, i2c, rtc, watchdog, adc on exynos7

Alim Akhtar (1):
      arm64: Enable ARMv8 based exynos7 SoC support

Naveen Krishna Ch (2):
      arm64: dts: Add initial device tree support for exynos7
      arm64: dts: Add initial pinctrl support to exynos7

 .../devicetree/bindings/arm/samsung/pmu.txt        |   1 +
 arch/arm64/Kconfig                                 |  17 +
 arch/arm64/boot/dts/Makefile                       |   1 +
 arch/arm64/boot/dts/exynos/Makefile                |   5 +
 arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |  84 +++
 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    | 588
+++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynos7.dtsi            | 530
+++++++++++++++++++
 7 files changed, 1226 insertions(+)
 create mode 100644 arch/arm64/boot/dts/exynos/Makefile
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-espresso.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynos7.dtsi


On 01/12/15 17:30, Kukjin Kim wrote:
> Hi again,
> 
> Please pull arm64 based exynos7 stuff for v3.20 and as you know I've
> tried this in 3.19 but couldn't because of some dependencies like clk.
> Now all of dependencies already resolved so this should be fine for v3.20.
> 
> If any problems, please kindly let me know.
> 
> Thanks,
> Kukjin
> 
> The following changes since commit 97bf6af1f928216fd6c5a66e8a57bfa95a659672:
> 
>   Linux 3.19-rc1 (2014-12-20 17:08:50 -0800)
> 
> are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> v3.20-next/dt-samsung-64
> 
> Abhilash Kesavan (2):
>       arm64: dts: Add PMU DT node for exynos7 SoC
>       arm64: dts: Add nodes for mmc, i2c, rtc, watchdog, adc on exynos7
> 
> Alim Akhtar (1):
>       arm64: Enable ARMv8 based exynos7 SoC support
> 
> Naveen Krishna Ch (2):
>       arm64: dts: Add initial device tree support for exynos7
>       arm64: dts: Add initial pinctrl support to exynos7
> 
>  .../devicetree/bindings/arm/samsung/pmu.txt        |    1 +
>  arch/arm64/Kconfig                                 |   17 +
>  arch/arm64/boot/dts/Makefile                       |    1 +
>  arch/arm64/boot/dts/exynos/Makefile                |    5 +
>  arch/arm64/boot/dts/exynos/exynos7-espresso.dts    |   84 +++
>  arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi    |  588
> ++++++++++++++++++++
>  arch/arm64/boot/dts/exynos/exynos7.dtsi            |  530
> ++++++++++++++++++
>  7 files changed, 1226 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm64/boot/dts/exynos/Makefile
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7-espresso.dts
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7-pinctrl.dtsi
>  create mode 100644 arch/arm64/boot/dts/exynos/exynos7.dtsi
