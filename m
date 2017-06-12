From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 13 Jun 2017 00:48:03 +0900
Subject: [GIT PULL] arm64: dts: uniphier: UniPhier DT updates (64bit) for v4.13
Message-ID: <CAK7LNATOnBVcxSu58gJzp6NpHd3R7z1cs9W+8SkqS2BAxgpt6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (64bit) updates for the v4.13 merge window.
Please pull!

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt64-v4.13

for you to fetch changes up to 1b6d58acdb26de8995f854cbf8b0d7214eefd884:

  arm64: dts: uniphier: add support for LD20 Global board (2017-06-13
00:00:17 +0900)

----------------------------------------------------------------
UniPhier ARM64 SoC DT updates for v4.13

- specify timing delay properties of eMMC
- fix W=1 build warnings
- increase memory reserve size
- use SPDX License Identifier
- add new board support (LD11/LD20 global)

----------------------------------------------------------------
Kunihiko Hayashi (2):
      arm64: dts: uniphier: add support for LD11 Global board
      arm64: dts: uniphier: add support for LD20 Global board

Masahiro Yamada (5):
      arm64: dts: uniphier: add input-delay properties to Cadence eMMC node
      arm64: dts: uniphier: add cdns, phy-dll-delay-sdclk(-hsmmc) for eMMC
      arm64: dts: uniphier: fix simple-bus unit address format error
      arm64: dts: uniphier: reserve more memory for LD11/LD20
      arm64: dts: uniphier: use SPDX-License-Identifier

Viresh Kumar (1):
      arm64: dts: uniphier: Use - instead of @ for DT OPP entries

 arch/arm64/boot/dts/socionext/Makefile                 |  2 +
 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts | 70
+++++++++++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld11-ref.dts    | 38 +--------------
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi       | 61
++++++------------------
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts | 52
++++++++++++++++++++
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts    | 38 +--------------
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 79
++++++++++---------------------
 7 files changed, 165 insertions(+), 175 deletions(-)
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ld11-global.dts
 create mode 100644 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts
m

-- 
Best Regards
Masahiro Yamada
