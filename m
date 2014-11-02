From: romain.perier@gmail.com (Romain Perier)
Date: Sun,  2 Nov 2014 10:19:59 +0000
Subject: [PATCH v3 0/2] ARM: dts: rockchip: EMAC Rockchip for RK3066 SoCs and
 MarsBoard RK3066
Message-ID: <1414923601-29504-1-git-send-email-romain.perier@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patches serie adds EMAC Rockchip support for RK3066 SoCs and defines an
initial devicetree source for MarsBoard RK3066.

changes since v2:
	- Squashed patch 1,2 and 4 together (this is the the second patch)
	- Add dual-licensing for rk3066a-marsboard.dts
	- Renamed regulator "vaux33_reg" to "vcc_rmii" as it is written in the
	  schematic

changes since v1:
	- Replaced hoayuelectronics by hoayu as suggested by the vendor-prefix doc in dt-bindings

Romain Perier (2):
  ARM: dts: rockchip: Add EMAC Rockchip for RK3066 SoCs
  ARM: dts: rockchip: Add devicetree source for MarsBoard RK3066

 Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
 arch/arm/boot/dts/Makefile                         |   1 +
 arch/arm/boot/dts/rk3066a-marsboard.dts            | 197 +++++++++++++++++++++
 arch/arm/boot/dts/rk3066a.dtsi                     |  22 +++
 4 files changed, 224 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3066a-marsboard.dts

-- 
1.9.1
