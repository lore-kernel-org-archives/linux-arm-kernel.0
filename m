From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Fri, 29 Nov 2013 20:18:14 +0100
Subject: [PATCH 0/3] ARM: OMAP2+: Remove remaining unused legacy code 
Message-ID: <1385752697-13700-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that OMAP2+ board files are scheduled for removal for v3.14
there is unused code that was only used by legacy platform code
and can be removed.

This patch-set depends on the series:

[PATCH 00/12] Drop omap3 board files and make mach-omap2 boot in DT only mode

and is composed of the following patches:

[PATCH 1/3] ARM: OMAP2+: Remove legacy smsc911x and smc91x GPMC
[PATCH 2/3] ARM: OMAP2+: Remove unnecesary include in GPMC driver
[PATCH 3/3] ARM: OMAP2+: Remove legacy board-flash.c

Best regards,
Javier
