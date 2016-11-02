From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  2 Nov 2016 15:18:48 +0100
Subject: [PATCH v2 0/3] ARM: dts: oxnas: Update support for OX820 and use
 dt-bindings
Message-ID: <20161102141850.25164-1-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset updates the ARM DTS for the Oxnas platform by :
- Add support for the Oxford Semicondutor OX820 and the PogoPlug V3
- Fix the MAINTAINERS entry and add the PogoPlug V3 file maintainance

Changes since v1 at http://lkml.kernel.org/r/20161021151037.20112-1-narmstrong at baylibre.com :
 - Due to a dt-bindings include dependency from clk and reset, the includes
 	are removed for the next release, and will be re-introduced after next
	merge window.

Neil Armstrong (2):
  ARM: dts: Add support for OX820 and Pogoplug V3
  MAINTAINERS: oxnas: Add new files definitions

 Documentation/devicetree/bindings/arm/oxnas.txt    |   5 +
 MAINTAINERS                                        |   3 +-
 arch/arm/boot/dts/Makefile                         |   3 +-
 .../boot/dts/cloudengines-pogoplug-series-3.dts    |  94 +++++++
 arch/arm/boot/dts/ox820.dtsi                       | 296 +++++++++++++++++++++
 5 files changed, 399 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/boot/dts/cloudengines-pogoplug-series-3.dts
 create mode 100644 arch/arm/boot/dts/ox820.dtsi

-- 
2.7.0
