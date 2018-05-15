From: heiko@sntech.de (Heiko Stuebner)
Date: Tue, 15 May 2018 15:54:53 +0200
Subject: [PATCH v2 0/4] rk3328 and rock64 display support
Message-ID: <20180515135457.6252-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Companion series for the display modifications adding the necessary
devicetree stuff for display support on the rk3328-rock64.

changes in v2:
- add defconfig addition for the phy driver
- adapt to changed reference clock names
- remove trailing 0 from vop irq

Heiko Stuebner (4):
  arm64: dts: rockchip: add Innosilicon hdmi phy node to rk3328
  arm64: dts: rockchip: add rk3328 display nodes
  arm64: dts: rockchip: enable display nodes on rk3328-rock64
  arm64: defconfig: enable Rockchip Innosilicon hdmiphy

 .../arm64/boot/dts/rockchip/rk3328-rock64.dts | 16 +++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi      | 70 +++++++++++++++++++
 arch/arm64/configs/defconfig                  |  1 +
 3 files changed, 87 insertions(+)

-- 
2.17.0
