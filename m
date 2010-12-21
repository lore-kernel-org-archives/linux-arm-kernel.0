From: adrian.hunter@nokia.com (Adrian Hunter)
Date: Tue, 21 Dec 2010 21:44:33 +0200
Subject: [PATCH 0/2] Add 104MHz support for OMAP OneNAND
Message-ID: <20101221194433.3127.74744.sendpatchset@ahunter-work.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Here is OMAP2/3: OneNAND: add 104MHz support.

Adrian Hunter (2):
      OMAP2/3: GPMC: put sync_clk value in picoseconds instead of nanoseconds
      OMAP2/3: OneNAND: add 104MHz support

 arch/arm/mach-omap2/gpmc-nand.c        |    2 +-
 arch/arm/mach-omap2/gpmc-onenand.c     |   19 ++++++++++++++-----
 arch/arm/mach-omap2/gpmc.c             |   12 +++++++++++-
 arch/arm/mach-omap2/usb-tusb6010.c     |    4 ++--
 arch/arm/plat-omap/include/plat/gpmc.h |    9 +++++----
 drivers/mtd/onenand/omap2.c            |    3 +++
 6 files changed, 36 insertions(+), 13 deletions(-)
 
Regards
Adrian
