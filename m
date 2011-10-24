From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 24 Oct 2011 15:50:41 +0200
Subject: [PATCH 0/2] mmc: mmci: Bugfixes for SDIO
Message-ID: <1319464243-16638-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchserie fixes some SDIO related issues for the mmci host driver.

Previously these patches were included in the patch serie called
"mmc: mmci: Improvements and bugfixes for SDIO", which now has been
split up.

Stefan Nilsson XK (1):
  mmc: mmci: Fix incorrect handling of HW flow control for SDIO

Ulf Hansson (1):
  mmc: mmci: Prepare for SDIO before setting up DMA job

 drivers/mmc/host/mmci.c |   50 ++++++++++++++++++++++++++--------------------
 1 files changed, 28 insertions(+), 22 deletions(-)

-- 
1.7.5.4
