From: prabhakar.csengg@gmail.com (Prabhakar lad)
Date: Mon,  8 Apr 2013 14:47:14 +0530
Subject: [PATCH v9 0/2] ARM: davinci: add support for dm365 vpbe display
Message-ID: <1365412636-3468-1-git-send-email-prabhakar.csengg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lad, Prabhakar <prabhakar.csengg@gmail.com>

This patch series enables VPBE display driver on DM365.

Changes for v9:
1: Removed extra line after break's and defines as pointed
   by Sekhar.
2: Included Ack's from Sekhar.

Changes for v8:
1: Fixed nits pointed by Sekhar.

Changes for v7:
1: Fixed nits pointed by Sekhar.

Changes for v6:
1: Fixed review comments pointed by Sekhar.

Changes for v5:
1: pass different platform names to handle different ip's.
2: Fixed review comments pointed by Sekhar.

Changes for v4:
1: Replaced the obsolete preset API by timings API.

Changes for v3:
1: Removed VPSS clock alias for master and slave which was
   sent for VPSS driver. since this patch was dependent on
   patch[1]. I will revist this patch once MC(captrure driver)
   goes into mainline.
[1] http://www.spinics.net/lists/linux-media/msg50562.html

Changes for v2:
1: Added VPSS clock so that capture and display
   can work independent.


Lad, Prabhakar (2):
  ARM: davinci: dm365: add support for v4l2 video display
  ARM: davinci: dm365 EVM: add support for VPBE display

 arch/arm/mach-davinci/board-dm365-evm.c |  166 +++++++++++++++++++++++++++-
 arch/arm/mach-davinci/davinci.h         |    7 +-
 arch/arm/mach-davinci/dm365.c           |  184 ++++++++++++++++++++++++++++---
 3 files changed, 340 insertions(+), 17 deletions(-)

-- 
1.7.4.1
