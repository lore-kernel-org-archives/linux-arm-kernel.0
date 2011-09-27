From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 27 Sep 2011 09:45:17 +0200
Subject: [PATCH 0/4] mmc: mmci: Improvements and bugfixes for SDIO
Message-ID: <1317109517-17869-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchserie fixes a couple of SDIO related issues for the mmci host
driver. The intention is to keep each patch small and to have one patch
for one problem. It might makes sence to squash some of the patches, but
I leave this for discussion.

Stefan Nilsson XK (3):
  mmc: mmci: Bugfix in pio read for small packets
  mmc: mmci: Support non-power-of-two block sizes for ux500v2 variant
  mmc: mmci: Fix incorrect handling of HW flow control for SDIO

Ulf Hansson (1):
  mmc: mmci: Prepare for SDIO before setting up DMA job

 drivers/mmc/host/mmci.c |   78 ++++++++++++++++++++++++++++++++---------------
 1 files changed, 53 insertions(+), 25 deletions(-)

-- 
1.7.5.4
