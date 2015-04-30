From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 30 Apr 2015 09:53:39 +0800
Subject: [PATCH RESEND 0/3] clk: mmp: fix and add new clock
Message-ID: <1430358822-4699-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

There are three patches
First two are fix patches.
The last one will add the timer clock for pxa168/mmp2/pxa910.

The timer driver will make use of the timer clock.

Chao Xie (3):
  clk: mmp: add fixed clock UBS_PLL for pxa910/pxa168
  clk: mmp: Fix the wrong factor table for uart PLL
  clk: mmp: add timer clock for pxa168/mmp2/pxa910

 drivers/clk/mmp/clk-mmp2.c                 |  4 +---
 drivers/clk/mmp/clk-of-mmp2.c              | 10 +++++++---
 drivers/clk/mmp/clk-of-pxa168.c            |  8 ++++++++
 drivers/clk/mmp/clk-of-pxa910.c            | 12 ++++++++++++
 include/dt-bindings/clock/marvell,mmp2.h   |  1 +
 include/dt-bindings/clock/marvell,pxa168.h |  3 +++
 include/dt-bindings/clock/marvell,pxa910.h |  4 ++++
 7 files changed, 36 insertions(+), 6 deletions(-)

-- 
1.8.3.2
