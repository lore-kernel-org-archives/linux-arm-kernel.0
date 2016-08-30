From: wxt@rock-chips.com (Caesar Wang)
Date: Wed, 31 Aug 2016 04:30:03 +0800
Subject: [PATCH 0/4] Support the rk3399 gmac pd function
Message-ID: <1472589008-7713-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add to handle the gmac pd issue, and support
the rk3399 gmac for devicetree.



Caesar Wang (2):
  arm64: dts: rockchip: support gmac for rk3399
  arm64: dts: rockchip: enable the gmac for rk3399 evb board

David Wu (1):
  net: stmmac: dwmac-rk: add pd_gmac support for rk3399

Roger Chen (1):
  net: stmmac: dwmac-rk: fixes the gmac resume after PD on/off

 arch/arm64/boot/dts/rockchip/rk3399-evb.dts    | 31 +++++++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi       | 90 ++++++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 27 +++++---
 3 files changed, 139 insertions(+), 9 deletions(-)

-- 
1.9.1
