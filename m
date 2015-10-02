From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 2 Oct 2015 09:40:44 +0300
Subject: [GIT PULL] clock: ti: fixes for 4.3-rc
Message-ID: <560E26EC.1030801@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen, Mike,

A few TI clock driver fixes to pull against 4.3-rc.

-Tero

================

The following changes since commit 9ffecb10283508260936b96022d4ee43a7798b4c:

   Linux 4.3-rc3 (2015-09-27 07:50:08 -0400)

are available in the git repository at:

   https://github.com/t-kristo/linux-pm.git for-4.3-rc/ti-clk-fixes

for you to fetch changes up to 7aba4f5201d1b7b3ddb0b03883d9edf69851ddad:

   clk: ti: dflt: fix enable_reg validity check (2015-10-02 09:24:28 +0300)

----------------------------------------------------------------
Ben Dooks (1):
       clk: ti: fix dual-registration of uart4_ick

Peter Ujfalusi (1):
       clk: ti: clk-7xx: Remove hardwired ABE clock configuration

Suman Anna (1):
       clk: ti: dflt: fix enable_reg validity check

  drivers/clk/ti/clk-3xxx.c  |    2 +-
  drivers/clk/ti/clk-7xx.c   |   18 +-----------------
  drivers/clk/ti/clkt_dflt.c |    4 ++--
  3 files changed, 4 insertions(+), 20 deletions(-)
