From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 28 Apr 2017 15:02:44 +0800
Subject: [PATCH v2 0/3] clk: rockchip: Perfect clock description for RK3228
Message-ID: <1493362967-4040-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

support more cpu freq, and support armcore div setting.
Add some necessary clks ID.

Change in V2:
separate [PATCH V1 2/2] into two patches with one adding the
clock-ids to the rk3228-cru.h and a second patch then doing the
assignment in clk-rk3228.c

Elaine Zhang (3):
  clk: rockchip: fix up the RK3228 clk cpu setting table
  clk: rockchip: add clock-ids for rk3228 clocks
  clk: rockchip: export rk3228 clocks ID

 drivers/clk/rockchip/clk-rk3228.c      | 142 +++++++++++++++++++--------------
 include/dt-bindings/clock/rk3228-cru.h |  47 +++++++++++
 2 files changed, 127 insertions(+), 62 deletions(-)

-- 
1.9.1
