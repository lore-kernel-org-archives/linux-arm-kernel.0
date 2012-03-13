From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 13 Mar 2012 22:55:22 +0530
Subject: [PATCH v2 0/2] Fixes in hwmod reset code
Message-ID: <1331659524-7635-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes a couple of issues around hwmod reset
APIs'.
Patches are based on 'hwmod_enable_remaining_hwmods_devel_3.4'
of git://git.pwsan.com/linux-2.6

Rajendra Nayak (2):
  ARM: omap: hwmod: Restore sysc after a reset
  ARM: omap: hwmod: Make omap_hwmod_softreset wait for reset status

 arch/arm/mach-omap2/omap_hwmod.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)
