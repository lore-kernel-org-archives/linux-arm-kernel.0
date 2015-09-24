From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Sep 2015 14:30:20 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Updates for v4.4
Message-ID: <cover.1443072491.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC updates for v4.4.

This pull request is based "Renesas ARM Based SoC Clk Updates for v4.4",
tagged as clk-for-v4.4, which I have also sent a pull-request for.


The following changes since commit e233d74c30f48108b7affb4e76bfc8f3c76b68ce:

  clk: shmobile: mstp: Consider "zb_clk" suitable for power management (2015-09-18 09:11:37 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-soc-for-v4.4

for you to fetch changes up to 8b98d74780ab70147d40400c36059c16c1aea4da:

  ARM: shmobile: R-Mobile: Use CPG/MSTP Clock Domain attach/detach helpers (2015-09-18 09:12:51 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Updates for v4.4

* ARM: shmobile: R-Mobile: Use CPG/MSTP Clock Domain attach/detach helpers

  This part of a multi-stage effort by Geert Uytterhoeven to add:

  "Clock Domain support to the Clock Pulse Generator (CPG) Module Stop
   (MSTP) Clocks driver using the generic PM Domain, to be used on shmobile
   SoCs without device power domains (R-Car Gen1 and Gen2, RZ).  This allows
   to power-manage the module clocks of SoC devices that are part of the
   CPG/MSTP Clock Domain using Runtime PM, or for system suspend/resume,
   similar to SoCs with device power domains (SH-Mobile and R-Mobile)."

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: R-Mobile: Use CPG/MSTP Clock Domain attach/detach helpers

 arch/arm/mach-shmobile/pm-rmobile.c | 35 +++--------------------------------
 1 file changed, 3 insertions(+), 32 deletions(-)
