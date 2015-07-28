From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 28 Jul 2015 06:27:18 +0000
Subject: [PATCH 0/7] clk: atlas7: a bind of fixes
Message-ID: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guo Zeng (5):
  clk: atlas7: add lost pwm unit clks
  clk: atlas7: export mux clks so that driver can use it
  clk: atlas7: fix the clock tree for bluetooth stuff
  clk: sirf: fix bit field and its root clk for coresight_tpiu
  clk: atlas7: fix pll missed divide NR in fraction mode

Yibo Cai (2):
  clk: sirf: fix integer overflow in dto rate calculation
  clk: atlas7: replace dto resolution magic number by macro

 drivers/clk/sirf/clk-atlas7.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

-- 
1.9.1
