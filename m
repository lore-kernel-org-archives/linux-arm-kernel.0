From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 22 Sep 2014 22:59:10 +0200
Subject: [GIT PULL] arm: mediatek: Add support for mt8127 and mt8135 SoCs
Message-ID: <CABuKBeK6iUdRqTuOZyTHW-Xt3O4giXoQTJ76vkh4Mv4cA52THQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof and Arnd,

Here comes the pull request to introduce mt8127 and mt8135 support.
It is based on the former pull request I send [0].

Cheers,
Matthias

[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-September/287506.html

---

The following changes since commit 467dc3a11b4c82dd94f4d0e8d6894cc60adef5ea:

  arm: dts: mt6589: Change compatible string for GIC (2014-09-09 18:37:50 +0200)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v3.18-next-mt81xx

for you to fetch changes up to f107b96ea9705aac9fd28c4278d4856062d3ebe8:

  arm: mediatek: Add earlyprintk support for mt8127 & mt8135
(2014-09-22 22:34:50 +0200)

----------------------------------------------------------------
Add support for mt8127 and mt8135 SoCs

----------------------------------------------------------------
Joe.C (7):
      arm: mediatek: Add basic support for mt8127
      arm: mediatek: add dts for 8127 Moose board
      arm: mediatek: Add basic support for mt8135
      arm: mediatek: add dts for MT8135 evaluation board.
      dt-bindings: add more chips in documentation for Mediatek SoC
      arm: dts: Build dtb for mt8127 & mt8135
      arm: mediatek: Add earlyprintk support for mt8127 & mt8135

 Documentation/devicetree/bindings/arm/mediatek.txt |  15 ++-
 arch/arm/Kconfig.debug                             |  20 ++++
 arch/arm/boot/dts/Makefile                         |   4 +-
 arch/arm/boot/dts/mt8127-moose.dts                 |  24 +++++
 arch/arm/boot/dts/mt8127.dtsi                      |  93 +++++++++++++++++
 arch/arm/boot/dts/mt8135-evbp1.dts                 |  24 +++++
 arch/arm/boot/dts/mt8135.dtsi                      | 115 +++++++++++++++++++++
 arch/arm/mach-mediatek/mediatek.c                  |   2 +
 8 files changed, 293 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/boot/dts/mt8127-moose.dts
 create mode 100644 arch/arm/boot/dts/mt8127.dtsi
 create mode 100644 arch/arm/boot/dts/mt8135-evbp1.dts
 create mode 100644 arch/arm/boot/dts/mt8135.dtsi
