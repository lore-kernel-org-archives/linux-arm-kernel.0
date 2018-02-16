From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 16 Feb 2018 23:38:14 +0100
Subject: [PATCH 0/3] rk3328 and rock64 display support
Message-ID: <20180216223817.2821-1-heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Companion series for the display modifications adding the necessary
devicetree stuff for display support on the rk3328-rock64.

Heiko Stuebner (3):
  arm64: dts: rockchip: add Innosilicon hdmi phy node to rk3328
  arm64: dts: rockchip: add rk3328 display nodes
  arm64: dts: rockchip: enable display nodes on rk3328-rock64

 arch/arm64/boot/dts/rockchip/rk3328-rock64.dts | 16 ++++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi       | 70 ++++++++++++++++++++++++++
 2 files changed, 86 insertions(+)

-- 
2.15.1
