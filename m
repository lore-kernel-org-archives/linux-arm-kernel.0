From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 14 Sep 2014 04:33:28 -0400
Subject: [GIT PULL] clk: mvebu changes for v3.18
Message-ID: <20140914083328.GU21986@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

It's pretty slow this cycle, here's the clock changes we've accrued for
mvebu.  They've been in -next.

Please pull.

thx,

Jason.


The following changes since commit 7d1311b93e58ed55f3a31cc8f94c4b8fe988a2b9:

  Linux 3.17-rc1 (2014-08-16 10:40:26 -0600)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/clk-mvebu-3.18

for you to fetch changes up to ceac26c64200015a5e6e358e903b1ca9a6f41dd8:

  clk: mvebu: armada-375: Fix the description of the SAR in the comment (2014-09-09 15:15:22 +0000)

----------------------------------------------------------------
clock changes for mvebu for v3.18

 - correct timer drift caused by SSCG deviation
 - fix typo in comment

----------------------------------------------------------------
Gregory CLEMENT (3):
      clk: mvebu: Fix clk frequency value if SSCG is enabled
      clk: mvebu: armada-370: Fix timer drift caused by the SSCG deviation
      clk: mvebu: armada-375: Fix the description of the SAR in the comment

 drivers/clk/mvebu/armada-370.c |  8 +++++
 drivers/clk/mvebu/armada-375.c |  4 +--
 drivers/clk/mvebu/common.c     | 82 ++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/mvebu/common.h     |  7 ++++
 4 files changed, 99 insertions(+), 2 deletions(-)
