From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Dec 2013 10:10:23 +0900
Subject: [GIT PULL] Renesas ARM based SoC Clock updates for v3.14
Message-ID: <1387761024-10114-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

please consider the following
Renesas ARM based SoC Clock updates for v3.14.

This pull request is based on your clk-next-shmobile branch.


The following changes since commit f94859c215b6d977794108a1a9a101239e393c09:

  clk: shmobile: Add MSTP clock support (2013-12-12 19:23:59 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clock-for-v3.14

for you to fetch changes up to 92ca6a8ce97e07206d474da5477d8da4e41bad6c:

  clk: emev2: Add support for emev2 SMU clocks with DT (2013-12-14 13:17:55 +0900)

----------------------------------------------------------------
Renesas ARM based SoC Clock updates for v3.14

Add support for using emev2 SMU clocks with DT

----------------------------------------------------------------
Takashi Yoshii (1):
      clk: emev2: Add support for emev2 SMU clocks with DT

 .../devicetree/bindings/clock/emev2-clock.txt      |  98 +++++++++++++++++++
 drivers/clk/shmobile/Makefile                      |   2 +-
 drivers/clk/shmobile/clk-emev2.c                   | 104 +++++++++++++++++++++
 3 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/clock/emev2-clock.txt
 create mode 100644 drivers/clk/shmobile/clk-emev2.c
