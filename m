From: khilman@ti.com (Kevin Hilman)
Date: Fri, 18 Nov 2011 11:22:38 -0800
Subject: [PATCH 0/2] ARM: OMAP: misc. PM fixes for v3.2-rc
Message-ID: <1321644160-19981-1-git-send-email-khilman@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony,

Here's a couple more PM fixes for v3.2-rc.

Also available here if you prefer to pull:

   git://git.kernel.org/pub/scm/linux/kernel/git/khilman/linux-omap-pm.git for_3.2/fixes/pm

(Note that this branch also includes the CPUidle fix that you already have
 in your fixes branch)

Kevin

Felipe Balbi (1):
  arm: omap: smartreflex: fix IRQ handling bug

Kevin Hilman (1):
  ARM: OMAP: PM: only register TWL with voltage layer when device is
    present

 arch/arm/mach-omap2/pm.c          |    6 ++----
 arch/arm/mach-omap2/smartreflex.c |    2 +-
 arch/arm/mach-omap2/twl-common.c  |   11 +++++++++++
 arch/arm/mach-omap2/twl-common.h  |    3 +++
 4 files changed, 17 insertions(+), 5 deletions(-)

-- 
1.7.6
