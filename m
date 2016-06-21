From: zhengxing@rock-chips.com (Xing Zheng)
Date: Tue, 21 Jun 2016 15:20:50 +0800
Subject: [PATCH 0/3] Add i2s/gmac dts nodes for RK322x SoCs
Message-ID: <1466493653-18611-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
  These patchset add i2s/gmac dts nodes for RK322x SoCs,
and add the new dts file of the rk3229 evb board.

Thanks.


Xing Zheng (3):
  ARM: dts: rockchip: add i2s nodes for RK3228 SoCs
  ARM: dts: rockchip: add GMAC nodes for RK3228 SoCs
  ARM: dts: rockchip: add support rk3229 evb board

 arch/arm/boot/dts/Makefile       |    1 +
 arch/arm/boot/dts/rk3228.dtsi    |  119 ++++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3229-evb.dts |   90 ++++++++++++++++++++++++++++
 3 files changed, 210 insertions(+)
 create mode 100644 arch/arm/boot/dts/rk3229-evb.dts

-- 
1.7.9.5
