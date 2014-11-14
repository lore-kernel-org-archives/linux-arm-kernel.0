From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Fri, 14 Nov 2014 16:54:04 +0100
Subject: [GIT PULL] ARM: mediatek: Add support for mt6592, mt8127 and mt8135
Message-ID: <CABuKBeLBdAaKyiOhVOUcvE9_ATYeMtccNP3zv_tdFvpgtxoMNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd and Olof,

Here comes the pull request which introduces basic support for
Mediatek SoCs mt6592, mt8127 and mt8135.

The patches for the mt81xx got merged in the late tree for v3.18 but
were not be merged at the end. They got a small fix regarding the
compatible and model string in the dts files.

Cheers,
Matthias

---

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v3.19-next-dts

for you to fetch changes up to 256e7653c8bac60f1ccf9e0a58cc45b01a7954b9:

  dt-bindings: add documentation for Mediatek SoC (2014-11-14 13:50:47 +0100)

----------------------------------------------------------------
Add support for mt6592, mt8127 and mt8135 Socs from Mediatek.

----------------------------------------------------------------
Howard Chen (3):
      ARM: mediatek: Add basic support for mt6592
      ARM: mediatek: add dts for mt6592-evb
      dt-bindings: add documentation for Mediatek SoC

Joe.C (6):
      ARM: mediatek: Add basic support for mt8127
      ARM: mediatek: add dts for 8127 Moose board
      ARM: mediatek: Add basic support for mt8135
      ARM: mediatek: add dts for MT8135 evaluation board.
      ARM: dts: Build dtb for mt8127 & mt8135
      dt-bindings: add more chips in documentation for Mediatek SoC

 Documentation/devicetree/bindings/arm/mediatek.txt |  19 +++-
 arch/arm/boot/dts/Makefile                         |   5 +-
 arch/arm/boot/dts/mt6592-evb.dts                   |  26 +++++
 arch/arm/boot/dts/mt6592.dtsi                      |  98 +++++++++++++++++
 arch/arm/boot/dts/mt8127-moose.dts                 |  25 +++++
 arch/arm/boot/dts/mt8127.dtsi                      |  94 +++++++++++++++++
 arch/arm/boot/dts/mt8135-evbp1.dts                 |  25 +++++
 arch/arm/boot/dts/mt8135.dtsi                      | 116 +++++++++++++++++++++
 arch/arm/mach-mediatek/mediatek.c                  |   3 +
 9 files changed, 407 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt6592-evb.dts
 create mode 100644 arch/arm/boot/dts/mt6592.dtsi
 create mode 100644 arch/arm/boot/dts/mt8127-moose.dts
 create mode 100644 arch/arm/boot/dts/mt8127.dtsi
 create mode 100644 arch/arm/boot/dts/mt8135-evbp1.dts
 create mode 100644 arch/arm/boot/dts/mt8135.dtsi
