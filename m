From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 22 Jul 2014 18:25:45 +0200
Subject: [GIT PULL v2] Mediatek basic support for v3.17
Message-ID: <CABuKBe+_Bosow3VeM5geMKHv9LagOik0BL_T+aarQU4pEbRXUQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patches 1-4 from v10 of the patch set have been merged by Daniel Lezcano [0].
This




----------------------------------------------------------------
The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  https://github.com/mbgg/linux-mediatek.git tags/v3.17-next-mediatek-support

for you to fetch changes up to afaedea451149ab8f08c37ce688c8021ed347811:

  arm: mediatek: add dts for Aquaris5 mobile phone (2014-07-22 17:52:38 +0200)

----------------------------------------------------------------
This patch set adds basic support for the Mediatek Cortex-A7 SoCs.

Support is quite basic, as the only component working up to now are the
timers.

----------------------------------------------------------------
Matthias Brugger (3):
      arm: add basic support for Mediatek MT6589 boards
      dt-bindings: add documentation for Mediatek SoC
      arm: mediatek: add dts for Aquaris5 mobile phone

 Documentation/devicetree/bindings/arm/mediatek.txt |    8 ++
 arch/arm/Kconfig                                   |    2 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/mt6589-aquaris5.dts              |   25 ++++++
 arch/arm/boot/dts/mt6589.dtsi                      |   94 ++++++++++++++++++++
 arch/arm/mach-mediatek/Kconfig                     |    6 ++
 arch/arm/mach-mediatek/Makefile                    |    1 +
 arch/arm/mach-mediatek/mediatek.c                  |   27 ++++++
 8 files changed, 164 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/mediatek.txt
 create mode 100644 arch/arm/boot/dts/mt6589-aquaris5.dts
 create mode 100644 arch/arm/boot/dts/mt6589.dtsi
 create mode 100644 arch/arm/mach-mediatek/Kconfig
 create mode 100644 arch/arm/mach-mediatek/Makefile
 create mode 100644 arch/arm/mach-mediatek/mediatek.c
