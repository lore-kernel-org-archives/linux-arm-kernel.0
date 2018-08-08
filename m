From: tony@atomide.com (Tony Lindgren)
Date: Wed,  8 Aug 2018 01:07:02 -0700
Subject: [PATCH 0/4] Few corner case fixes for ti-sysc
Message-ID: <20180808080706.100389-1-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are few corner case fixes for ti-sysc.

Regards,

Tony


Tony Lindgren (4):
  ARM: OMAP2+: Fix null hwmod for ti-sysc debug
  ARM: OMAP2+: Fix module address for modules using mpu_rt_idx
  bus: ti-sysc: Fix module register ioremap for larger offsets
  bus: ti-sysc: Fix no_console_suspend handling

 arch/arm/mach-omap2/omap_hwmod.c | 39 +++++++++++++++++++++++++++++++-
 drivers/bus/ti-sysc.c            | 35 ++++++++++++++--------------
 2 files changed, 55 insertions(+), 19 deletions(-)

-- 
2.17.1
