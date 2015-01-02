From: nm@ti.com (Nishanth Menon)
Date: Fri, 2 Jan 2015 11:17:50 -0600
Subject: [PATCH 0/2] ARM: l2c: OMAP4/AM437x: Additional register programming
 support.
Message-ID: <1420219072-6521-1-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

OMAP4 and AM437x ROM code provides services to program PL310's latency
registers and AM437x provides service for programming Address filter
registers.

Provide support in the kernel for the same.

This provides some support to the series: http://marc.info/?l=linux-arm-kernel&m=141933190912495&w=2

Nishanth Menon (2):
  ARM: l2c: OMAP4/AM437x: Introduce support for cache latency
    programming
  ARM: l2c: AM437x: Introduce support for cache filter programming

 arch/arm/mach-omap2/common.h       |    1 +
 arch/arm/mach-omap2/omap-secure.h  |    2 ++
 arch/arm/mach-omap2/omap-smc.S     |   20 ++++++++++++++++++++
 arch/arm/mach-omap2/omap4-common.c |   36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)

Regards,
Nishanth Menon

-- 
1.7.9.5
