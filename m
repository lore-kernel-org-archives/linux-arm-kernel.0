From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  5 Sep 2017 23:19:58 +0200
Subject: [PATCH v2 0/2] ARM: Actions Semi S500 SMP cleanups
Message-ID: <20170905212000.7009-1-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This mini-series further cleans up the SMP code for Actions Semi S500 SoC.

@David, can you please reply with an Acked-by for the second patch? Thanks!

Work branch for testing:
https://github.com/afaerber/linux/commits/bg96-next

Have a lot of fun!

Cheers,
Andreas

v1 -> v2:
* Prepended __pa_symbol cleanup (Florian)

Cc: David Liu <liuwei@actions-semi.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>

Andreas F?rber (2):
  ARM: owl: smp: Use __pa_symbol()
  ARM: owl: smp: Drop owl_secondary_boot()

 arch/arm/mach-actions/Makefile  |  4 +---
 arch/arm/mach-actions/headsmp.S | 52 -----------------------------------------
 arch/arm/mach-actions/platsmp.c |  2 +-
 3 files changed, 2 insertions(+), 56 deletions(-)
 delete mode 100644 arch/arm/mach-actions/headsmp.S

-- 
2.13.5
