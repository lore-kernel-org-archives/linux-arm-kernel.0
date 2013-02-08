From: dbrignoli@audioscience.com (Delio Brignoli)
Date: Fri,  8 Feb 2013 10:44:23 +0100
Subject: [PATCH 0/1] ARM: OMAP: ASI1230: Create board support and enable build
 for ASI1230
Message-ID: <1360316664-17210-1-git-send-email-dbrignoli@audioscience.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

According to MAINTAINERS, linux-arm-kernel should be the right list for this patch.
Please let me know if it isn't. Please apply.

Thanks
-- 
Delio Brignoli
AudioScience Inc

Delio Brignoli (1):
  ARM: OMAP: ASI1230: Create board support and enable build for ASI1230

 arch/arm/mach-omap2/Kconfig                   |    5 +++
 arch/arm/mach-omap2/Makefile                  |    1 +
 arch/arm/mach-omap2/board-asi1230.c           |   44 +++++++++++++++++++++++++
 arch/arm/mach-omap2/include/mach/uncompress.h |    1 +
 4 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-asi1230.c
