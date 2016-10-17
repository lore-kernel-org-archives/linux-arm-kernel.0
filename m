From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 17 Oct 2016 14:39:58 +0200
Subject: [RFC PATCH 0/3] ARM: dts: oxnas: Update support for OX820 and use
 dt-bindings
Message-ID: <20161017124001.23820-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates the ARM DTS for the Oxnas platform by :
- Add support for the Oxford Semicondutor OX820 and the PogoPlug V3
- Update the OX810SE to use the dt-bindings includes files introduced in [1] and [2]
- Fix the MAINTAINERS entry and add the PogoPlug V3 file maintainance

This patchset remains RFC until dependent patches [1] and [2] are merged.

[1] https://listengine.tuxfamily.org/lists.tuxfamily.org/linux-oxnas/2016/10/msg00008.html
[2] https://listengine.tuxfamily.org/lists.tuxfamily.org/linux-oxnas/2016/10/msg00007.html

Neil Armstrong (3):
  ARM: dts: Add support for OX820 and Pogoplug V3
  ARM: dts: OX810: Update with dt-bindings includes
  MAINTAINERS: oxnas: Add new files definitions

 Documentation/devicetree/bindings/arm/oxnas.txt    |   5 +
 MAINTAINERS                                        |   3 +-
 arch/arm/boot/dts/Makefile                         |   3 +-
 .../boot/dts/cloudengines-pogoplug-series-3.dts    |  60 +++++
 arch/arm/boot/dts/ox810se.dtsi                     |  10 +-
 arch/arm/boot/dts/ox820.dtsi                       | 259 +++++++++++++++++++++
 6 files changed, 334 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
 create mode 100644 arch/arm/boot/dts/ox820.dtsi

-- 
2.7.0
