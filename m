From: ezequiel@collabora.com (Ezequiel Garcia)
Date: Thu,  5 Jul 2018 12:08:16 -0300
Subject: [PATCH v3 0/2] arm64: rockchip: support RK3399 Ficus board
Message-ID: <20180705150818.29931-1-ezequiel@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's the third spin for the RK3399 Ficus support.

Changes from v2:
 * Dropped rk3399.dtsi changes and rebased on top of Randy's patch.
 * Removed double empty line.
 * Coalesced schematics comment

Changes from v1:
 * Dropoed USB support as it's not working.
 * Added schematics.
 * Splitted rk3399.dtsi from new ficus.dts file.
 * Added new vendor.
 * Cleaned regulators syntax and stlye.

Series based on: 600b359d2b98 ("arm64: dts: rockchip: add some common pin-settings to rk3399").

Ezequiel Garcia (2):
  dt-bindings: Add vendor prefix for Vamrs Ltd.
  arm64: dts: rockchip: add 96boards RK3399 Ficus board

 .../devicetree/bindings/arm/rockchip.txt      |   5 +
 .../devicetree/bindings/vendor-prefixes.txt   |   1 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 514 ++++++++++++++++++
 4 files changed, 521 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-ficus.dts

-- 
2.18.0.rc2
