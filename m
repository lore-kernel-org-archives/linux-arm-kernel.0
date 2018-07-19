From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 19 Jul 2018 12:28:07 +0800
Subject: [PATCH v2 0/3] Allwinner H6 MMC support
Message-ID: <20180719042810.6546-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for MMC controller in the Allwinner H6 SoC.

Its function is a superset of the A64 MMC controller's, so it currently
use A64 compatible as a fallback.

Icenowy Zheng (3):
  dt-binding: mmc: sunxi: add H6 compatible (with A64 fallback)
  arm64: allwinner: h6: add device tree nodes for MMC controllers
  arm64: allwinner: h6: enable MMC0/2 on Pine H64

 .../devicetree/bindings/mmc/sunxi-mmc.txt     |  2 +
 .../boot/dts/allwinner/sun50i-h6-pine-h64.dts | 18 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 59 +++++++++++++++++++
 3 files changed, 79 insertions(+)

-- 
2.17.1
