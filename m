From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 11 May 2010 16:47:05 -0700
Subject: [PATCH 0/6] OMAP PM core updates for 2.6.35 [updated]
Message-ID: <1273621631-9148-1-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A small series of OMAP PM core updates for 2.6.35.

Applies on v2.6.34-rc6.

Also available here in my pm-next branch here:
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git pm-next

Ari Kauppi (1):
  OMAP3: PM: Add milliseconds interface to suspend wakeup timer

Kevin Hilman (1):
  OMAP3: PRCM interrupt: only check and clear enabled PRCM IRQs

Mike Chan (2):
  OMAP3: PM: Enable IO / IO-CHAIN wakeups for PER
  OMAP3: PM: Remove PER wakeup dependency on CORE.

Ranjith Lohithakshan (2):
  OMAP3EVM: Update pad configuration for wakeup enabled pads
  OMAP3: PM: Enable wakeup from ads7846 touchscreen

 arch/arm/mach-omap2/board-3430sdp.c  |    1 +
 arch/arm/mach-omap2/board-omap3evm.c |    6 ++--
 arch/arm/mach-omap2/pm-debug.c       |    3 ++
 arch/arm/mach-omap2/pm.h             |    1 +
 arch/arm/mach-omap2/pm34xx.c         |   58 +++++++++++++++++++--------------
 5 files changed, 41 insertions(+), 28 deletions(-)
