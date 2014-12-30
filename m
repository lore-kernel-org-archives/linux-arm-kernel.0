From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Tue, 30 Dec 2014 16:41:45 +0800
Subject: [PATCH 0/2] dmaengine: fsl-edma: add dma memcpy and suspend/resume
 support
Message-ID: <1419928907-18053-1-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  This two patches add the dma memory copy and PM suspend/resume support
for the Freescale eDMA engine.

----------------------------------------------------------------
Jingchang Lu (2):
	dmaengine: fsl-edma: add dma memcpy support
	dmaengine: fsl-edma: add PM suspend/resume support

 drivers/dma/fsl-edma.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 99 insertions(+), 2 deletions(-)
