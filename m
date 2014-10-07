From: kever.yang@rock-chips.com (Kever Yang)
Date: Tue,  7 Oct 2014 17:33:56 +0800
Subject: [PATCH 0/2] init some clock rate from dts for rk3288
Message-ID: <1412674438-26160-1-git-send-email-kever.yang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add init rate for PLLs and some bus clock  from dts for rk3288,
add two clock rate of 400M and 500M into rate table for we will use it.


Kever Yang (2):
  clk: rockchip: add 400MHz and 500MHz for rk3288 clock rate
  ARM: dts: enable init rate for clock

 arch/arm/boot/dts/rk3288.dtsi     | 10 ++++++++++
 drivers/clk/rockchip/clk-rk3288.c |  2 ++
 2 files changed, 12 insertions(+)

-- 
1.9.1
