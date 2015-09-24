From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Sep 2015 14:29:59 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Clk Updates for v4.4
Message-ID: <cover.1443072085.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC clk updates for v4.4.

The patch was acked by Stephen earlier this month
https://lkml.org/lkml/2015/9/17/822


The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-clk-for-v4.4

for you to fetch changes up to e233d74c30f48108b7affb4e76bfc8f3c76b68ce:

  clk: shmobile: mstp: Consider "zb_clk" suitable for power management (2015-09-18 09:11:37 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Clk Updates for v4.4

* Consider "zb_clk" suitable for power management

  This part of a multi-stage effort by Geert Uytterhoeven to add:

  "Clock Domain support to the Clock Pulse Generator (CPG) Module Stop
   (MSTP) Clocks driver using the generic PM Domain, to be used on shmobile
   SoCs without device power domains (R-Car Gen1 and Gen2, RZ).  This allows
   to power-manage the module clocks of SoC devices that are part of the
   CPG/MSTP Clock Domain using Runtime PM, or for system suspend/resume,
   similar to SoCs with device power domains (SH-Mobile and R-Mobile)."

----------------------------------------------------------------
Geert Uytterhoeven (1):
      clk: shmobile: mstp: Consider "zb_clk" suitable for power management

 drivers/clk/shmobile/clk-mstp.c | 4 ++++
 1 file changed, 4 insertions(+)
