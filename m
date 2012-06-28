From: khilman@ti.com (Kevin Hilman)
Date: Thu, 28 Jun 2012 10:01:30 -0700
Subject: [PATCH 0/2] ARM: OMAP: few more PM fixes for v3.5-rc
Message-ID: <1340902892-9542-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony, here are hopefully the last couple PM-related fixes for v3.5-rc.

Both of these fix suspend/resume/wakeup problems on OMAP3 or OMAP4.

Thanks,

Kevin

Kevin Hilman (2):
  ARM: OMAP2: Overo: init I2C before MMC to fix MMC suspend/resume
    failure
  ARM: OMAP4: TWL6030: ensure sys_nirq1 is mux'd and wakeup enabled

 arch/arm/mach-omap2/board-overo.c |    2 +-
 arch/arm/mach-omap2/twl-common.c  |    2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

-- 
1.7.9.2
