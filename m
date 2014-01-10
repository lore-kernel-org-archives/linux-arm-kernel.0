From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 10 Jan 2014 11:57:28 +0200
Subject: [PATCH 0/2] ARM: DRA7XX/AM43XX build fixes
Message-ID: <1389347850-22435-1-git-send-email-t-kristo@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The move of clock code from mach-omap2 to drivers/clk/ti introduces
a couple of new build errors with AM43XX/DRA7XX only builds. The
following patches address these issues by modifying the Kconfig + Makefile
under mach-omap2.

Also, it seems DRA7XX only build is not possible at the moment, added
patch #2 to fix this.

-Tero
