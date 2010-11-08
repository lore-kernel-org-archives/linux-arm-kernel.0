From: balbi@ti.com (Felipe Balbi)
Date: Mon,  8 Nov 2010 08:56:13 +0200
Subject: [PATCH 0/2] combine zoom board-files
Message-ID: <1289199375-9001-1-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Those boards are so similar they don't deserve
separate board files.

Felipe Balbi (2):
  arm: omap: combine zoom2 and zoom3 board-files
  arm: omap: zoom: substitute gpio number with symbolic name

 arch/arm/mach-omap2/Makefile                       |    4 +-
 .../arm/mach-omap2/{board-zoom3.c => board-zoom.c} |  104 ++++++++++-------
 arch/arm/mach-omap2/board-zoom2.c                  |  117 --------------------
 3 files changed, 64 insertions(+), 161 deletions(-)
 rename arch/arm/mach-omap2/{board-zoom3.c => board-zoom.c} (75%)
 delete mode 100644 arch/arm/mach-omap2/board-zoom2.c

-- 
1.7.3.2.146.gca209
