From: tony@atomide.com (Tony Lindgren)
Date: Tue, 08 Jun 2010 15:03:05 +0300
Subject: [PATCH 0/5] omap fixes for 2.6.35-rc2
Message-ID: <20100608120104.24902.36055.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are few omap fixes for review. I've moved anything that's not
absolutely needed as a fix into for-next as requested by Linus.

Regards,

Tony

---

Amit Kucheria (1):
      omap: fix build failure due to missing include dma-mapping.h

Kevin Hilman (2):
      omap: GPIO: fix auto-disable of debounce clock
      OMAP3: PM: fix IO daisy chain enable to use PM_WKEN reg

Santosh Shilimkar (1):
      omap: Stalker board: switch over to gpio_set_debounce

Tero Kristo (1):
      omap: DMTIMER: Ack pending interrupt always when stopping a timer


 arch/arm/mach-omap2/board-omap3stalker.c |    4 +---
 arch/arm/mach-omap2/pm34xx.c             |    4 ++--
 arch/arm/mach-omap2/usb-ehci.c           |    2 ++
 arch/arm/plat-omap/dmtimer.c             |    6 +++---
 arch/arm/plat-omap/gpio.c                |    1 +
 5 files changed, 9 insertions(+), 8 deletions(-)

-- 
Signature
