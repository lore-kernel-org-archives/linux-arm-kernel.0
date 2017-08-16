From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 16 Aug 2017 12:00:52 +0900
Subject: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.14
Message-ID: <CAK7LNAQpsNrrrL2T8J1QYjA+9cmj8UO3JdTCZ7_WLGfdWC4G7w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Here are UniPhier DT (32bit) updates for the v4.14 merge window.
Please pull!


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.14

for you to fetch changes up to 69f9cdc63319e5ccc210b30d1cec1dfda7096b04:

  ARM: dts: uniphier: add Denali NAND controller node (2017-08-16
01:47:01 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.14

- complete migrating to SPDX License Identifier
- remove support for old SoC
- add nodes for NAND, Audio pinctrl
- replace /include/ with #include

----------------------------------------------------------------
Katsuhiro Suzuki (1):
      ARM: dts: uniphier: add audio out pin-mux node

Masahiro Yamada (4):
      ARM: dts: uniphier: use SPDX-License-Identifier (2nd)
      ARM: dts: uniphier: remove sLD3 SoC support
      ARM: dts: uniphier use #include instead of /include/
      ARM: dts: uniphier: add Denali NAND controller node

 arch/arm/boot/dts/Makefile                 |   1 -
 arch/arm/boot/dts/uniphier-ld4-ref.dts     |  10 +-
 arch/arm/boot/dts/uniphier-ld4.dtsi        |  13 +-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts    |  10 +-
 arch/arm/boot/dts/uniphier-ld6b.dtsi       |   2 +-
 arch/arm/boot/dts/uniphier-pinctrl.dtsi    |  43 +---
 arch/arm/boot/dts/uniphier-pro4-ace.dts    |   2 +-
 arch/arm/boot/dts/uniphier-pro4-ref.dts    |  10 +-
 arch/arm/boot/dts/uniphier-pro4-sanji.dts  |   2 +-
 arch/arm/boot/dts/uniphier-pro4.dtsi       |  13 +-
 arch/arm/boot/dts/uniphier-pro5.dtsi       |  51 ++---
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts |   2 +-
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts  |   2 +-
 arch/arm/boot/dts/uniphier-pxs2.dtsi       |  13 +-
 arch/arm/boot/dts/uniphier-sld3-ref.dts    |  75 -------
 arch/arm/boot/dts/uniphier-sld3.dtsi       | 260 ----------------------
 arch/arm/boot/dts/uniphier-sld8-ref.dts    |  10 +-
 arch/arm/boot/dts/uniphier-sld8.dtsi       |  13 +-
 18 files changed, 100 insertions(+), 432 deletions(-)
 delete mode 100644 arch/arm/boot/dts/uniphier-sld3-ref.dts
 delete mode 100644 arch/arm/boot/dts/uniphier-sld3.dtsi






-- 
Best Regards
Masahiro Yamada
