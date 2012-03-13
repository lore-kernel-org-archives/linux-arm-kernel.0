From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 13 Mar 2012 19:25:26 +0530
Subject: [PATCH 0/2] Fixes in hwmod reset code
Message-ID: <1331646928-31119-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a couple of issues around hwmod reset
APIs'.
Patches are based on 3.3.-rc7.

Rajendra Nayak (2):
  ARM: omap: hwmod: Restore sysc after a reset
  ARM: omap: hwmod: Make omap_hwmod_softreset wait for reset status

 arch/arm/mach-omap2/omap_hwmod.c |   18 +++++++-----------
 1 files changed, 7 insertions(+), 11 deletions(-)
