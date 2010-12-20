From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 20 Dec 2010 22:57:41 +0800
Subject: [PATCH v8 00/15] ARM: mxs: Add initial support for MX23 and MX28
Message-ID: <1292857064-5032-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes for v8:
 - Reuse debug-pl01x.S as mxs DUART is just an amba-pl011
 - Remove extra space in iomux.c
 - Remove uncessary line breaker in mach-mx23evk.c

 [PATCH v8 05/15] ARM: mxs: Add low-level debug UART support
 [PATCH v8 08/15] ARM: mxs: Add iomux support
 [PATCH v8 13/15] ARM: mxs: Add initial mx23evk support

Thanks for the review comments.

Regards,
Shawn
