From: zyw@rock-chips.com (Chris Zhong)
Date: Tue, 25 Nov 2014 17:37:31 +0800
Subject: [PATCH 0/2] Increase the maximum cpu frequency of rk3288
Message-ID: <1416908253-31721-1-git-send-email-zyw@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The maximum cpu frequency of rk3288 can up to 1.8Ghz, but the vdd_cpu need set
to 1.4v. I've tested these patches on rk3288 evb board.


Chris Zhong (2):
  ARM: dts: rockchip: change the max voltage of cpu to 1.4v
  ARM: dts: rk3288: change the max clk of cpu to 1.8Ghz

 arch/arm/boot/dts/rk3288-evb-rk808.dts | 2 +-
 arch/arm/boot/dts/rk3288.dtsi          | 6 ++++--
 2 files changed, 5 insertions(+), 3 deletions(-)

-- 
1.9.1
