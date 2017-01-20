From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 20 Jan 2017 23:21:00 +0100
Subject: [PATCH 00/18] ARM64: meson: DT cleanups
Message-ID: <20170120222118.21476-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series fixes several cosmetic issues, on top of v4.11/dt64 branch.

Patches 3-5 rename a node, the rest should all be non-functional changes.
Patches 10-18 could be squashed if desired.

Regards,
Andreas

Cc: devicetree at vger.kernel.org

Andreas F?rber (18):
  Documentation: devicetree: amlogic: Reorder boards
  ARM64: dts: amlogic: Sort Makefile
  ARM64: dts: meson-gxbb-vega-s95: Fix Wifi node name
  ARM64: dts: meson-gxbb-p20x: Fix Wifi node name
  ARM64: dts: meson-gx-p23x-q20x: Fix Wifi node name
  ARM64: dts: meson-gxm-nexbox-a1: Drop UART comment
  ARM64: dts: meson-gxl-s905x: Comment typo fix
  ARM64: dts: meson-gxm: Drop trailing white line
  ARM64: dts: meson-gxbb-wetek-hub: Reference CVBS node by label
  ARM64: dts: meson-gxbb: Reorder nodes
  ARM64: dts: meson-gxbb-odroidc2: Reorder nodes
  ARM64: dts: meson-gxbb-vega-s95: Reorder nodes
  ARM64: dts: meson-gxbb-nexbox-a95x: Reorder nodes
  ARM64: dts: meson-gxbb-p20x: Reorder nodes
  ARM64: dts: meson-gxl: Reorder nodes
  ARM64: dts: meson-gxl-s905x-nexbox-a95x: Reorder nodes
  ARM64: dts: meson-gxm-nexbox-a1: Reorder nodes
  ARM64: dts: meson-gx-p23x-q20x: Reorder nodes

 Documentation/devicetree/bindings/arm/amlogic.txt  | 19 ++++--
 arch/arm64/boot/dts/amlogic/Makefile               |  4 +-
 .../arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi | 26 ++++----
 .../boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 28 ++++----
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 52 +++++++--------
 arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   | 58 ++++++++---------
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi      | 53 ++++++++-------
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts      |  6 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 76 +++++++++++-----------
 .../dts/amlogic/meson-gxl-s905x-nexbox-a95x.dts    | 28 ++++----
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x.dtsi   |  2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi         | 40 ++++++------
 .../arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts | 59 +++++++++--------
 arch/arm64/boot/dts/amlogic/meson-gxm.dtsi         |  1 -
 14 files changed, 228 insertions(+), 224 deletions(-)

-- 
2.10.2
