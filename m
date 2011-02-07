From: adrian.hunter@nokia.com (Adrian Hunter)
Date: Mon,  7 Feb 2011 10:46:57 +0200
Subject: [PATCH 0/4] Fix 104MHz support for OMAP OneNAND
Message-ID: <1297068421-14430-1-git-send-email-adrian.hunter@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

Adrian Hunter (3):
      OMAP: OneNAND: fix 104MHz support
      OMAP: OneNAND: determine frequency in one place
      OMAP: OneNAND: let boards determine OneNAND frequency

Roman Tereshonkov (1):
      mtd: OneNAND: OMAP2: increase multiblock erase verify timeout

 arch/arm/mach-omap2/gpmc-onenand.c        |  113 +++++++++++++++++++++--------
 arch/arm/plat-omap/include/plat/onenand.h |   10 +++-
 drivers/mtd/onenand/omap2.c               |   36 ++-------
 include/linux/mtd/onenand_regs.h          |    1 +
 4 files changed, 100 insertions(+), 60 deletions(-)
 
Regards
Adrian
