From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 23 Jan 2014 10:47:39 +0800
Subject: [PATCH 0/3] clk: mmp: bug fix for clk-frac
Message-ID: <1390445262-27486-1-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

When use the clk-frac type of mmp, some bugs are found.
The following 3 patches are bug fix for clk-frac

Chao Xie (3):
  clk: mmp: fix wrong mask when calculate denominator
  clk: mmp: fix the wrong calculation formula
  clk: mmp: try to use closer one when do round rate

 drivers/clk/mmp/clk-frac.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

-- 
1.8.3.2
