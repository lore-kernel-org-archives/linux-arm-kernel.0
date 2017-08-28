From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 29 Aug 2017 00:28:21 +0900
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates (64bit) for
 v4.14 (2nd)
Message-ID: <CAK7LNAS3D1pJrEXWLWL30FbLOA6rt65MYBiLKqB=jhhQRt4YZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,


Sorry for my last-minute pull request.
Please pull a little more for the upcoming merge window.
Here are some trivial + new SoC support for UniPhier DT (64bit).
Please pull!


The following changes since commit e5aefb380eafe176de066ddde1d354a167a9d474:

  arm64: dts: uniphier: add Denali NAND controller nodes (2017-08-13
08:43:27 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v4.14-2

for you to fetch changes up to c28adcb536109f54ddf349ee2fd9beef084d4d88:

  arm64: dts: uniphier: add PXs3 SoC support (2017-08-29 00:13:53 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v4.14 (2nd)

- add reset controller node of analog amplifier
- add AIDET irqchip device nodes
- fix size of sdctrl node
- support new SoC PXs3 and its reference development board

----------------------------------------------------------------
Katsuhiro Suzuki (1):
      arm64: dts: uniphier: add reset controller node of analog amplifier

Masahiro Yamada (3):
      arm64: dts: uniphier: add AIDET nodes
      arm64: dts: uniphier: fix size of sdctrl node
      arm64: dts: uniphier: add PXs3 SoC support

 arch/arm64/boot/dts/socionext/Makefile              |   3 +-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi    |  18 ++
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi    |  20 +-
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts |  62 ++++
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi    | 367
++++++++++++++++++++++
 5 files changed, 468 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi


-- 
Best Regards
Masahiro Yamada
