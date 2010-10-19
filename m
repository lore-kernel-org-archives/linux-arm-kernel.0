From: balbi@ti.com (Felipe Balbi)
Date: Tue, 19 Oct 2010 10:30:53 +0300
Subject: [PATCH 0/2] Trivial series
Message-ID: <1287473455-25773-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

found these while compiling n770_defconfig. Probably
worth sending to mainline anyway ?

Felipe Balbi (2):
  arm: omap1: devices: need to return with a value
  arm: omap1: remove unused variables

 arch/arm/mach-omap1/devices.c |    2 +-
 arch/arm/mach-omap1/mailbox.c |    1 -
 arch/arm/mach-omap1/pm_bus.c  |    1 -
 3 files changed, 1 insertions(+), 3 deletions(-)

-- 
1.7.3.rc0.35.g8ac8c
