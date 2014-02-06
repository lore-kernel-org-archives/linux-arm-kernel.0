From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:14:00 +0900
Subject: [GIT PULL] Renesas CPG update for v3.15
Message-ID: <cover.1391651474.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

please consider this Renesas CPG update for v3.15.


The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-cpg-for-v3.15

for you to fetch changes up to a028c6da34d434e35ba8322568c756ea97ff3c18:

  ARM: shmobile: wait for MSTP clock status to toggle, when enabling it (2014-02-04 10:22:39 +0900)

----------------------------------------------------------------
Renesas CPG update for v3.15

* Wait for MSTP clock status to toggle when enabling it

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      ARM: shmobile: wait for MSTP clock status to toggle, when enabling it

 drivers/sh/clk/cpg.c   | 38 ++++++++++++++++++++++++++++++++++++++
 include/linux/sh_clk.h | 19 ++++++++++++-------
 2 files changed, 50 insertions(+), 7 deletions(-)
