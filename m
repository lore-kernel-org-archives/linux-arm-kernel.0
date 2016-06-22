From: zhengxing@rock-chips.com (Xing Zheng)
Date: Wed, 22 Jun 2016 11:16:49 +0800
Subject: [RESEND PATCH v2 0/4] Add support i2s/spdif/gmac features for RK322x
 SoCs
Message-ID: <1466565413-31027-1-git-send-email-zhengxing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,
  We have the brother chipset product that RK3228 and RK3229,
They have many common configuration, but there are a number
of different features. In order to develop the future when they
are easy to distinguish, we need them to be independent.
  And, these patchset add i2s/gmac dts nodes for RK322x SoCs,
and add the new dts file of the rk3229 evb board.

Thanks.

Changes in v2:
- rename rk3228.dtsi to rk322x.dtsi

Xing Zheng (4):
  ARM: dts: rockchip: rename rk3228.dtsi to rk322x.dtsi
  ARM: dts: rockchip: add i2s nodes for RK322x SoCs
  ARM: dts: rockchip: add GMAC nodes for RK322x SoCs
  ARM: dts: rockchip: add support rk3229 evb board

 arch/arm/boot/dts/Makefile       |    1 +
 arch/arm/boot/dts/rk3228.dtsi    |  548 +----------------------------
 arch/arm/boot/dts/rk3229-evb.dts |   90 +++++
 arch/arm/boot/dts/rk3229.dtsi    |   45 +++
 arch/arm/boot/dts/rk322x.dtsi    |  708 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 845 insertions(+), 547 deletions(-)
 create mode 100644 arch/arm/boot/dts/rk3229-evb.dts
 create mode 100644 arch/arm/boot/dts/rk3229.dtsi
 create mode 100644 arch/arm/boot/dts/rk322x.dtsi

-- 
1.7.9.5
