From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 26 Apr 2013 12:38:09 +0100
Subject: [PATCH 1/6] dmaengine: Refactor the DMA40 driver - continued
Message-ID: <1366976295-11728-1-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a continuation of the first "dmaengine: Refactor the DMA40 driver"
patch-set. It encompasses some recommendations given during the review of
it's predecessor.

 arch/arm/mach-ux500/board-mop500-audio.c    |   12 +++++-----
 arch/arm/mach-ux500/board-mop500-sdi.c      |   16 ++++++-------
 arch/arm/mach-ux500/board-mop500.c          |   22 ++++++++---------
 arch/arm/mach-ux500/usb.c                   |    4 ++--
 drivers/dma/ste_dma40.c                     |   99 +++++++++++++++++++++++++++++++++-------------------------------------------
 drivers/dma/ste_dma40_ll.c                  |  122 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------
 include/linux/platform_data/dma-ste-dma40.h |   19 ++-------------
 sound/soc/ux500/ux500_pcm.c                 |   10 ++++----
 8 files changed, 147 insertions(+), 157 deletions(-)
