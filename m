From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Thu, 23 May 2013 15:13:44 +0200
Subject: [PATCH 0/6] ARM: ux500: Update configurations for SD/SDIO/(e)MMC
Message-ID: <1369314830-3727-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

This patchset includes especially enablement for UHS-I SD cards, but
also some cleanups and additional enabling of SD/SDIO/(e)MMC features.

These changes shall also be adapted to the corresponding DT files,
but that is left as a separate task and outside this patchset.

Ulf Hansson (6):
  ARM: ux500: Enable 100MHz for SD/SDIO/MMC devices
  ARM: ux500: Don't set plf ocr mask for SD/MMC device
  ARM: ux500: Enable support for RPMB and Reliable Write for eMMC
  ARM: ux500: Enable support for discard for MMC/SD
  ARM: ux500: Set eMMC and WLAN card slot as non-removable
  ARM: ux500: Enable support for UHS-I SD-cards

 arch/arm/mach-ux500/board-mop500-sdi.c |   34 +++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 12 deletions(-)

-- 
1.7.10
