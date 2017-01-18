From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 18 Jan 2017 11:50:39 +0100
Subject: [PATCH 0/3] ARM64: meson-gxbb: Add WeTek Boards
Message-ID: <1484736642-5451-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie adds support for the WeTek Hub and Play2 boards.
The Hub is an extremely small IPTv Set-Top-Box and the Play2 is a more
traditionnal Satellite or Terrestrial and IPTv Set-Top-Box.

Both are based on the p200 Reference Design and out-of-tree support is
based on OpenELEC kernel at [1].

[1] https://github.com/wetek-enigma/linux-amlogic

Neil Armstrong (3):
  dt-bindings: vendor-prefix: Add wetek vendor prefix
  ARM64: dts: meson-gxbb: Add support for WeTek Hub and Play
  dt-bindings: amlogic: Add WeTek boards

 Documentation/devicetree/bindings/arm/amlogic.txt  |  2 +
 .../devicetree/bindings/vendor-prefixes.txt        |  1 +
 arch/arm64/boot/dts/amlogic/Makefile               |  2 +
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      | 66 +++++++++++++++
 .../boot/dts/amlogic/meson-gxbb-wetek-play2.dts    | 94 ++++++++++++++++++++++
 5 files changed, 165 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts

-- 
1.9.1
