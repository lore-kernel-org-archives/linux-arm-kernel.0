From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 2 Oct 2014 09:50:48 -0400
Subject: [GIT PULL] clk: mvebu: Last change for v3.18
Message-ID: <20141002135048.GB27230@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

Sorry I'm a bit late with this one.  This is a small fix on top of the
previous pull request you already took.  It's been in linux-next for at
least 10 of Stephen's 'next-YYYYMMDD' tags.  So hopefully you don't mind
taking it.  If it's too late for you, this could probably be a
fixes-non-critical for v3.18-rc1.

Hopefully, you can still take it since it looks like the opening of the
merge window is going to be delayed a week.

This is an incremental pull request from tags/clk-mvebu-3.18 up to
tags/clk-mvebu-3.18-2 on the mvebu/drivers-clk branch.

Please pull.

thx,

Jason.


The following changes since commit ceac26c64200015a5e6e358e903b1ca9a6f41dd8:

  clk: mvebu: armada-375: Fix the description of the SAR in the comment (2014-09-09 15:15:22 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/clk-mvebu-3.18-2

for you to fetch changes up to 5f093ee76c8fc1ec82de8da04bd087663c853e7b:

  clk: mvebu: fix sscg node lookup (2014-09-16 15:39:33 +0000)

----------------------------------------------------------------
clock mvebu changes for v3.18 (round 2)

 - armada 370/375
    - Fix SSCG node lookup

----------------------------------------------------------------
Thomas Petazzoni (1):
      clk: mvebu: fix sscg node lookup

 drivers/clk/mvebu/common.c | 6 +++---
 drivers/clk/mvebu/common.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)
