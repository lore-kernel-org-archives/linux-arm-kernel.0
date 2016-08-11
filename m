From: roger.chen@rock-chips.com (Roger Chen)
Date: Thu, 11 Aug 2016 15:24:45 +0800
Subject: [PATCH 0/3] support GMAC for RK3399 & RK3366
Message-ID: <1470900288-10109-1-git-send-email-roger.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds registers description for RK3366 & RK3399 GMAC.
And also DT nodes for RK3399 SoC and EVB.

Roger Chen (3):
  net: stmmac: dwmac-rk: add rk3366 & rk3399 specific data
  arm64: dts: rockchip: add GMAC dt nodes for rk3399 SoC
  arm64: dts: rockchip: add GMAC dt nodes for RK3399 evb

 .../devicetree/bindings/net/rockchip-dwmac.txt     |   4 +-
 arch/arm64/boot/dts/rockchip/rk3399-evb.dts        |  23 +++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi           |  79 +++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c     | 226 +++++++++++++++++++++
 4 files changed, 330 insertions(+), 2 deletions(-)

-- 
1.9.1
