From: eddie.cai.linux@gmail.com (Eddie Cai)
Date: Wed, 19 Apr 2017 15:30:21 +0800
Subject: [PATCH 0/2] correct id for clk_testout1
Message-ID: <20170419073023.1921-1-eddie.cai.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the id for clk_testout1 is wrong, it's time to correct it. 

Eddie Cai (2):
  clk: rockchip: add SCLK_TESTCLKOUT1 id
  clk: rockchip: fix the incorrect id for clk_testout1

 drivers/clk/rockchip/clk-rk3399.c      | 2 +-
 include/dt-bindings/clock/rk3399-cru.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

-- 
2.10.2
