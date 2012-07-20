From: prabhakar.lad@ti.com (Prabhakar Lad)
Date: Fri, 20 Jul 2012 19:59:15 +0530
Subject: [PATCH v2 0/2] ARM: davinci: add support for dm365 vpbe display driver
Message-ID: <1342794557-16951-1-git-send-email-prabhakar.lad@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Prabhkar Lad <prabhakar.lad@ti.com>

This patch series enables VPBE display driver on DM365.

Changes for V2:
1: Added VPSS clock so that capture and display
   can work independent.

Manjunath Hadli (2):
  ARM: davinci: dm365: add support for v4l2 video display
  ARM: davinci: dm365 EVM: add support for VPBE display

 arch/arm/mach-davinci/board-dm365-evm.c |  178 +++++++++++++++++++++++++-
 arch/arm/mach-davinci/davinci.h         |    2 +-
 arch/arm/mach-davinci/dm365.c           |  218 +++++++++++++++++++++++++++++--
 3 files changed, 385 insertions(+), 13 deletions(-)
