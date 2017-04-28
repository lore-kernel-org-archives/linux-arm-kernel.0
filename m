From: zhangqing@rock-chips.com (Elaine Zhang)
Date: Fri, 28 Apr 2017 10:33:19 +0800
Subject: [PATCH v1 0/2] clk: rockchip: Perfect clock description for RK3228
Message-ID: <1493346801-23785-1-git-send-email-zhangqing@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

support more cpu freq, and support armcore div setting.
Add some necessary clks ID.

Elaine Zhang (2):
  clk: rockchip: fix up the RK3228 clk cpu setting table
  clk: rockchip: export rk3228 clocks ID

 drivers/clk/rockchip/clk-rk3228.c      | 142 +++++++++++++++++++--------------
 include/dt-bindings/clock/rk3228-cru.h |  47 +++++++++++
 2 files changed, 127 insertions(+), 62 deletions(-)

-- 
1.9.1
