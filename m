From: eddie.cai.linux@gmail.com (Eddie Cai)
Date: Tue, 25 Apr 2017 14:41:08 +0800
Subject: [PATCH V2  0/2] correct ids for clk_testout
Message-ID: <1493102470-22965-1-git-send-email-eddie.cai.linux@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we use clk_testout1 and clk_testout2 for camera. e.g. mipi 24M mclk. the ids of
clk_testout1 and clk_testout2 is wrong. it's time to correct it. 

Eddie Cai (2):
  clk: rockchip: add ids for camera
  clk: rockchip: fix the incorrect ids

 drivers/clk/rockchip/clk-rk3399.c      | 4 ++--
 include/dt-bindings/clock/rk3399-cru.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.9.1
