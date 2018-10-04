From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 4 Oct 2018 09:53:48 +0900
Subject: [GIT PULL v2] ARM: dts: uniphier: UniPhier DT updates for v4.20
Message-ID: <CAK7LNAR90vJA6vyEP_6_zmW_CAoxrHQC8-iAK0ixn6+o2uQfkg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

Please pull UniPhier DT updates for the v4.20 MW.

This is v2, for which I picked up a little more patches.


In this cycle, I queued up all arm/arm64 changes
into a single branch to avoid build errors.

Thanks!



The following changes since commit 5b394b2ddf0347bef56e50c69a58773c94343ff3:

  Linux 4.19-rc1 (2018-08-26 14:11:59 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-uniphier.git
tags/uniphier-dt-v4.20

for you to fetch changes up to 546cba0623df695ac84c10a821cf98fea24b2a18:

  arm64: dts: uniphier: Add USB2 PHY nodes (2018-10-04 09:41:06 +0900)

----------------------------------------------------------------
UniPhier ARM SoC DT updates for v4.20

- Add more clocks to NAND controller nodes

- Add SPI controller nodes

- Add SD controller nodes

- Add USB 3.0 and its PHY nodes

- Add PHY nodes for USB 2.0

----------------------------------------------------------------
Kunihiko Hayashi (7):
      ARM: dts: uniphier: add SPI pin-mux node
      ARM: dts: uniphier: add SPI node for UniPhier 32bit SoCs
      arm64: dts: uniphier: add SPI node for LD20, LD11 and PXs3
      ARM: dts: uniphier: Add USB3 controller nodes
      ARM: dts: uniphier: Add USB2 PHY nodes
      arm64: dts: uniphier: Add USB3 controller nodes
      arm64: dts: uniphier: Add USB2 PHY nodes

Masahiro Yamada (4):
      ARM: uniphier: dts: add more clocks to Denali NAND controller node
      arm64: uniphier: dts: add more clocks to Denali NAND controller node
      ARM: dts: uniphier: add SD/eMMC controller nodes
      arm64: dts: uniphier: add SD controller nodes

 arch/arm/boot/dts/uniphier-ld4-ref.dts                 |   4 +
 arch/arm/boot/dts/uniphier-ld4.dtsi                    |  48 +++-
 arch/arm/boot/dts/uniphier-ld6b-ref.dts                |  12 +
 arch/arm/boot/dts/uniphier-pinctrl.dtsi                |  25 ++
 arch/arm/boot/dts/uniphier-pro4-ace.dts                |  12 +
 arch/arm/boot/dts/uniphier-pro4-ref.dts                |  12 +
 arch/arm/boot/dts/uniphier-pro4-sanji.dts              |  12 +
 arch/arm/boot/dts/uniphier-pro4.dtsi                   | 189 ++++++++++++++-
 arch/arm/boot/dts/uniphier-pro5.dtsi                   |  59 ++++-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts             |  12 +
 arch/arm/boot/dts/uniphier-pxs2-vodka.dts              |   8 +
 arch/arm/boot/dts/uniphier-pxs2.dtsi                   | 239
++++++++++++++++++-
 arch/arm/boot/dts/uniphier-sld8-ref.dts                |   4 +
 arch/arm/boot/dts/uniphier-sld8.dtsi                   |  48 +++-
 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi       |  52 ++++-
 arch/arm64/boot/dts/socionext/uniphier-ld20-global.dts |   4 +
 arch/arm64/boot/dts/socionext/uniphier-ld20-ref.dts    |   4 +
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi       | 255
+++++++++++++++++++-
 arch/arm64/boot/dts/socionext/uniphier-pxs3-ref.dts    |  12 +
 arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi       | 283
++++++++++++++++++++++-
 20 files changed, 1286 insertions(+), 8 deletions(-)



-- 
Best Regards
Masahiro Yamada
