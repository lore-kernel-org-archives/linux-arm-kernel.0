From: zhengxing@rock-chips.com (Xing Zheng)
Date: Mon, 28 Dec 2015 15:22:17 +0800
Subject: [RESEND PATCH v1 0/4] Add support emac for the RK3036 SoC platform
Message-ID: <1451287341-16453-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
  We have supported the emac for RK3066/RK3188, but the RK3036 have some
configuration different with them. We should let the driver of emac_rockchip
compatible with other Rockchip SoCs.



Xing Zheng (4):
  net: ethernet: arc: Probe emac after set RMII clock
  net: ethernet: arc: Keep emac compatibility for more Rockchip SoCs
  net: ethernet: arc: Add support emac for RK3036
  ARM: dts: rockchip: Add support emac for RK3036

 arch/arm/boot/dts/rk3036-evb.dts         |   25 +++++++++
 arch/arm/boot/dts/rk3036-kylin.dts       |   23 ++++++++
 arch/arm/boot/dts/rk3036.dtsi            |   32 +++++++++++
 drivers/net/ethernet/arc/Kconfig         |    4 +-
 drivers/net/ethernet/arc/emac_rockchip.c |   86 ++++++++++++++++++++----------
 5 files changed, 140 insertions(+), 30 deletions(-)

-- 
1.7.9.5
