From: prabhakar.csengg@gmail.com (Prabhakar Lad)
Date: Mon,  3 Dec 2012 16:09:48 +0530
Subject: [PATCH v4 0/2] ARM: davinci: dm355: add support for vpbe display
Message-ID: <1354531190-11073-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Manjunath Hadli <manjunath.hadli@ti.com>

This patch series enables VPBE display driver on DM355.

Changes for v4:
1: pass different platform names to handle different ip's.

Changes for v3:
1: Replaced obsolete preset API by timings API.

Changes for v2:
1: Removed VPSS clock alias for master and slave which was
   sent for VPSS driver. since this patch was dependent on
   patch[1]. I will revist this patch once MC(captrure driver)
   goes into mainline.
[1] http://www.spinics.net/lists/linux-media/msg50562.html

Manjunath Hadli (2):
  ARM: davinci: dm355: add support for v4l2 video display
  ARM: davinci: dm355 EVM: add support for VPBE display

 arch/arm/mach-davinci/board-dm355-evm.c |   73 +++++++++++-
 arch/arm/mach-davinci/davinci.h         |    2 +-
 arch/arm/mach-davinci/dm355.c           |  202 +++++++++++++++++++++++++++++--
 3 files changed, 266 insertions(+), 11 deletions(-)

-- 
1.7.4.1
