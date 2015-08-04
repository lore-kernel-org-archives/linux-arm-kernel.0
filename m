From: 21cnbao@gmail.com (Barry Song)
Date: Tue,  4 Aug 2015 14:45:25 +0000
Subject: [PATCH 0/7 v2] clk: atlas7: a bind of fixes
Message-ID: <1438699532-13860-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-v2: refine commit title according to the feedback of Stephen Boyd

Guo Zeng (5):
  clk: atlas7: add lost pwm unit clks
  clk: atlas7: export mux clks so that consumers can get them
  clk: atlas7: fix the clock tree for bluetooth stuff
  clk: atlas7: fix bit field and its root clk for coresight_tpiu
  clk: atlas7: fix pll missed divide NR in fraction mode

Yibo Cai (2):
  clk: atlas7: fix integer overflow in dto rate calculation
  clk: atlas7: replace dto resolution magic number by macro

 drivers/clk/sirf/clk-atlas7.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

-- 
1.9.1
