From: jacob-chen@iotwrt.com (Jacob Chen)
Date: Sat,  1 Jul 2017 10:02:42 +0800
Subject: [PATCH 0/5] some devicetree changes for rk3288 boards
Message-ID: <1498874567-11219-1-git-send-email-jacob-chen@iotwrt.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Guillaume have send patches for mali gpu node, let's enable it in more boards.

Jacob Chen (5):
  ARM: dts: rockchip: enable ARM Mali GPU on rk3288-tinker
  ARM: dts: rockchip: enable ARM Mali GPU on rk3288-evb
  ARM: dts: rockchip: enable ARM Mali GPU on rk3288-fennec
  ARM: dts: rockchip: enable saradc for rk3288-evb
  ARM: dts: rockchip: enable adc key for rk3288-evb

 arch/arm/boot/dts/rk3288-evb.dtsi   | 56 +++++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/rk3288-fennec.dts |  5 ++++
 arch/arm/boot/dts/rk3288-tinker.dts |  5 ++++
 3 files changed, 66 insertions(+)

-- 
2.7.4
