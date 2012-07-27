From: prabhakar.lad@ti.com (Prabhakar Lad)
Date: Fri, 27 Jul 2012 17:34:13 +0530
Subject: [PATCH v2 0/2] ARM: davinci: add support for dm355 vpbe display driver
Message-ID: <1343390655-23863-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series enables VPBE display driver on DM355.

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
 arch/arm/mach-davinci/dm355.c           |  210 +++++++++++++++++++++++++++++--
 3 files changed, 274 insertions(+), 11 deletions(-)
