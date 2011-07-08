From: j.weitzel@phytec.de (Jan Weitzel)
Date: Fri, 8 Jul 2011 12:04:21 +0200
Subject: [PATCH 0/3] ARM:OMAP4 add Phytec phyCORE-OMAP4 board
Message-ID: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds support for the Phytec OMAP4430 board called phyCORE-OMAP4 PCM049.
GPMC is used for the smsc911x. A gpmc clk fix is needed.

The lcd display "pd050vl1" for the generic_dpi_panel gets own patch.

Jan

Jan Weitzel (3):
  ARM: OMAP4: Add pcm049 to Kconfig/Makefile
  ARM: OMAP4: add pcm049 DEBUGLL
  ARM: OMAP4: platformcode board-omap4pcm049.c

 arch/arm/mach-omap2/Kconfig                  |    5 +
 arch/arm/mach-omap2/Makefile                 |    4 +
 arch/arm/mach-omap2/board-omap4pcm049.c      |  728 ++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/uncompress.h |    1 +
 4 files changed, 738 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/board-omap4pcm049.c
