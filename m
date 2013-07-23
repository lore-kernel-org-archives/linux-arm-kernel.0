From: jonathan.austin@arm.com (Jonathan Austin)
Date: Tue, 23 Jul 2013 16:42:16 +0100
Subject: [PATCH 0/2] Restore Integrator/CP CLCD to fully working state
Message-ID: <1374594138-17080-1-git-send-email-jonathan.austin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Over time and with refactoring, the use of the Integrator/CP LCD seems to have
broken.

This series restores the ability to use the Integrator's CLCD and an external
VGA display.

Jonathan Austin (2):
  ARM: integrator_cp: Set LCD{0,1} enable lines when turning on CLCD
  clk: fixup argument order when setting VCO parameters

 arch/arm/mach-integrator/integrator_cp.c |    3 ++-
 drivers/clk/versatile/clk-icst.c         |    2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
1.7.9.5
