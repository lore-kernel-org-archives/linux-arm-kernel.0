From: carlo@caione.org (Carlo Caione)
Date: Sat,  4 Mar 2017 21:26:22 +0100
Subject: [PATCH v3 0/2] Add support for HwaCom AmazeTV
Message-ID: <20170304202624.29682-1-carlo@caione.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@endlessm.com>

New DTS to support the HwaCom AmazeTV based on the Meson S905X SoC.

Changelog:
 v2:
  - Changed DTS name to meson-gxl-s905x-hwacom-amazetv.dts
 v3:
  - Split patchset in two parts: DTS and documentation update
  - Makefile now sorted alphabetically
  - DTS nodes now sorted alphabetically

Carlo Caione (2):
  dt-bindings: amlogic: Add HwaCom board
  ARM64: dts: meson-gxl: Add support for HwaCom AmazeTV

 Documentation/devicetree/bindings/arm/amlogic.txt  |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts | 164 +++++++++++++++++++++
 3 files changed, 166 insertions(+)
 create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-hwacom-amazetv.dts

-- 
2.12.0
