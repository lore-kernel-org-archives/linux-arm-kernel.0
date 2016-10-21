From: narmstrong@baylibre.com (Neil Armstrong)
Date: Fri, 21 Oct 2016 17:10:34 +0200
Subject: [PATCH 0/3] ARM: dts: oxnas: Update support for OX820 and use
 dt-bindings
Message-ID: <20161021151037.20112-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates the ARM DTS for the Oxnas platform by :
- Add support for the Oxford Semicondutor OX820 and the PogoPlug V3
- Update the OX810SE to use the dt-bindings includes files introduced in [1] and [2]
- Fix the MAINTAINERS entry and add the PogoPlug V3 file maintainance

This patchset depends on dt-bindings include headers posted at [1] and [2],
that were accepted/merged in the subsystem trees.

How could I manage this dependency for 4.10 ?

[1] https://listengine.tuxfamily.org/lists.tuxfamily.org/linux-oxnas/2016/10/msg00008.html
[2] https://listengine.tuxfamily.org/lists.tuxfamily.org/linux-oxnas/2016/10/msg00007.html

Neil Armstrong (3):
  ARM: dts: Add support for OX820 and Pogoplug V3
  ARM: dts: OX810: Update with dt-bindings includes
  MAINTAINERS: oxnas: Add new files definitions

 Documentation/devicetree/bindings/arm/oxnas.txt    |   5 +
 MAINTAINERS                                        |   3 +-
 arch/arm/boot/dts/Makefile                         |   3 +-
 .../boot/dts/cloudengines-pogoplug-series-3.dts    |  94 +++++++
 arch/arm/boot/dts/ox810se.dtsi                     |  10 +-
 arch/arm/boot/dts/ox820.dtsi                       | 298 +++++++++++++++++++++
 6 files changed, 407 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
 create mode 100644 arch/arm/boot/dts/ox820.dtsi

-- 
2.7.0
