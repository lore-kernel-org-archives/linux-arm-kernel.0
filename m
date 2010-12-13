From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 13 Dec 2010 20:54:57 +0800
Subject: [PATCH v6 00/15] ARM: mxs: Add initial support for MX23 and MX28
Message-ID: <1292244903-30392-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes for v6 of this patch series:
 - Introduce inline functions __mxs_setl(), __mxs_clrl()
   and __mxs_togl() for bit set/clear/toggle operations
 - Address comments given by Uwe on gpio.c (detailed change log
   can be found in the patch version log)
 - Remove cpu.o from arch/arm/mach-mxs/Makefile

 [PATCH v6 01/15] ARM: mxs: Add core definitions
 [PATCH v6 03/15] ARM: mxs: Add reset routines
 [PATCH v6 06/15] ARM: mxs: Add timer support
 [PATCH v6 07/15] ARM: mxs: Add gpio support
 [PATCH v6 08/15] ARM: mxs: Add iomux support
 [PATCH v6 15/15] ARM: mxs: Add build configuration for mxs
