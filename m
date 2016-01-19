From: paweljarosz3691@gmail.com (=?UTF-8?q?Pawe=C5=82=20Jarosz?=)
Date: Tue, 19 Jan 2016 13:09:18 +0100
Subject: [PATCH 0/3] Add rk3066 tsadc device tree bindings
Message-ID: <1453205361-27267-1-git-send-email-paweljarosz3691@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds devicetree bindings for rockchip rk3066 tsadc with needed dependencies.

Pawe? Jarosz (3):
  clk: rockchip: Add new id for rk3066 tsadc clock
  clk: rockchip: add tsadc clock on rk3066
  ARM: dts: rockchip: add tsadc node

 arch/arm/boot/dts/rk3066a.dtsi                | 11 +++++++++++
 drivers/clk/rockchip/clk-rk3188.c             |  2 +-
 include/dt-bindings/clock/rk3188-cru-common.h |  1 +
 3 files changed, 13 insertions(+), 1 deletion(-)

-- 
1.9.1
