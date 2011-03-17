From: balajitk@ti.com (Balaji T K)
Date: Thu, 17 Mar 2011 21:30:03 +0530
Subject: [PATCH 0/3] ARM: OMAP2+: gpmc warning fixes
Message-ID: <1300377606-16616-1-git-send-email-balajitk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Applies on omap-for-linus branch
Boot tested on OMAP4430 SDP and OMAP3630SDP

Balaji T K (3):
  ARM: OMAP2+: correct GPMC IRQ
  ARM: OMAP2+: GPMC set dummy irq chip
  ARM: OMAP4: correct GPMC IRQ number

 arch/arm/mach-omap2/gpmc.c             |   13 ++++++++-----
 arch/arm/plat-omap/include/plat/irqs.h |    2 +-
 2 files changed, 9 insertions(+), 6 deletions(-)
