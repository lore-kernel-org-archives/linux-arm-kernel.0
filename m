From: carlo@caione.org (Carlo Caione)
Date: Sun, 12 Feb 2017 20:32:45 +0100
Subject: [PATCH 0/2] Add support for HwaCom AmazeTV
Message-ID: <20170212193247.22705-1-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

Add support for HwaCom AmazeTV, one more S905X board.

Carlo Caione (2):
  devicetree: Add vendor prefix for Hwacom Systems Inc.
  ARM64: dts: meson-gxl: Add support for HwaCom AmazeTV

 Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-gxl-hwacom-amazetv.dts  | 201 +++++++++++++++++++++
 4 files changed, 204 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-hwacom-amazetv.dts

-- 
2.9.3
