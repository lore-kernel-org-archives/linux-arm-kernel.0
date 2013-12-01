From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 1 Dec 2013 12:07:52 -0500
Subject: [GIT PULL] clk: mvebu: for v3.14
Message-ID: <20131201170752.GT2879@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

Here's the first round for v3.14.  These have been in -next for a week
now, without problem.

thx,

Jason.


The following changes since commit 6ce4eac1f600b34f2f7f58f9cd8f0503d79e42ae:

  Linux 3.13-rc1 (2013-11-22 11:30:55 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-clk-3.14

for you to fetch changes up to a2473b6c8279b95c5fa954f765da65cc27d6e2d2:

  clk: mvebu: Add Core Divider clock (2013-11-24 17:29:25 +0000)

----------------------------------------------------------------
mvebu clock changes for v3.14

 - mvebu: add the core divider clock driver
 - sparse cleanup

----------------------------------------------------------------
Ezequiel Garcia (1):
      clk: mvebu: Add Core Divider clock

Jisheng Zhang (1):
      clk: mvebu: staticize of_cpu_clk_setup

 drivers/clk/mvebu/Kconfig       |   5 +
 drivers/clk/mvebu/Makefile      |   1 +
 drivers/clk/mvebu/clk-corediv.c | 223 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/mvebu/clk-cpu.c     |   2 +-
 4 files changed, 230 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mvebu/clk-corediv.c
