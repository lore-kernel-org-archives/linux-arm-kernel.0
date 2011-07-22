From: nm@ti.com (Nishanth Menon)
Date: Fri, 22 Jul 2011 00:55:51 -0500
Subject: [PATCH 0/2] OMAP3+: PM: SR fixes
Message-ID: <1311314153-23531-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,
Please find attached a couple of patches collected as part of SR stabilization
around idle and a slight improvement for suspend path. The second patch
could probably help at a later date as part of moving the SmartReflex driver
off as a seperate independent driver of it's own.

These are based on Linus master v3.0-rc7

Colin Cross (1):
  OMAP3+: PM: SR: use put_sync_suspend for disabling

Nishanth Menon (1):
  OMAP2+: PM: SR: add suspend/resume handlers

 arch/arm/mach-omap2/smartreflex.c |   89 ++++++++++++++++++++++++++++++++++++-
 1 files changed, 88 insertions(+), 1 deletions(-)

-- 
Regards,
Nishanth Menon
