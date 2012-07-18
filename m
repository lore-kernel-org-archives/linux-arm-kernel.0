From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 18 Jul 2012 11:52:21 +0800
Subject: [PATCH v2 0/2] A couple of clk fixes
Message-ID: <1342583543-20404-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is v2 of a couple of related clk fixes from myself and Rob. It
has these two patches be a series and has changes correctly partitioned
there.

Rob Herring (1):
  clk: fix compile for OF && !COMMON_CLK

Shawn Guo (1):
  clk: fix clk_get on of_clk_get_by_name return check

 drivers/clk/clkdev.c |    4 ++--
 include/linux/clk.h  |    7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
1.7.4.1
