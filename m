From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Jun 2013 05:00:08 +0900
Subject: [GIT PULL 03/10] Samsung EXYNOS DT-2 for v3.11
Message-ID: <51C0BC48.8030805@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit a38089057fa450944f2e2d07885d76fd727c8d16:

   ARM: dts: add ohci and ehci controller nodes for EXYNOS5440 
(2013-06-12 04:58:34 +0900)

are available in the git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git 
tags/exynos-dt-2

for you to fetch changes up to 5f13269130d6798571ffbd9d84dbef0950984c5b:

   ARM: dts: Set BUCK7 as always on for Origen board (2013-06-19 
00:41:56 +0900)

----------------------------------------------------------------
2nd exynos dt update based on tags/exynos-dt-1
- enable RTC on exynos5250 snow and Arndale boards
- add support LCD and PWM for exynos4210 Origen board
- update bootargs to support 8GiB for exynos5440 SSDK5440 and SD5v1 boards
- enable spi and add opp level for exynos5440
- add example doc for samsung-pinctrl dt bindings

----------------------------------------------------------------
Amit Daniel Kachhap (1):
       ARM: dts: Add more opp levels in exynos5440

Doug Anderson (1):
       ARM: dts: Enable RTC node for exynos5250-snow

Giridhar Maruthy (1):
       ARM: dts: Removing pdma for exynos5440

Girish K S (1):
       ARM: dts: enable spi for EXYNOS5440 SOC

Leela Krishna Amudala (1):
       Documentation: Add examples to samsung-pinctrl device tree 
bindings documentation

Padmavathi Venna (1):
       ARM: dts: Add wm8994 regulator support on smdk5250

Sachin Kamat (3):
       ARM: dts: Add PWM related pinctrl entries for exynos4210
       ARM: dts: Add LCD related pinctrl entries for exynos4210
       ARM: dts: Add FIMD node to Origen4210 board

Subash Patel (1):
       ARM: dts: update bootargs to support 8GiB for SSDK5440 and SD5v1

Tushar Behera (2):
       ARM: dts: Enable RTC node for Arndale
       ARM: dts: Set BUCK7 as always on for Origen board

  .../bindings/pinctrl/samsung-pinctrl.txt           | 44 ++++++++++-
  arch/arm/boot/dts/exynos4210-origen.dts            | 22 ++++++
  arch/arm/boot/dts/exynos4210-pinctrl.dtsi          | 89 
++++++++++++++++++++++
  arch/arm/boot/dts/exynos5250-arndale.dts           |  3 +
  arch/arm/boot/dts/exynos5250-smdk5250.dts          | 37 ++++++++-
  arch/arm/boot/dts/exynos5250-snow.dts              |  4 +
  arch/arm/boot/dts/exynos5440-sd5v1.dts             |  2 +-
  arch/arm/boot/dts/exynos5440-ssdk5440.dts          | 41 +++++++++-
  arch/arm/boot/dts/exynos5440.dtsi                  | 41 ++++------
  9 files changed, 248 insertions(+), 35 deletions(-)
