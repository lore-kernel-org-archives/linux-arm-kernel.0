From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 09 Jun 2010 11:39:02 +0200
Subject: [PATCH] SDHCI-S3C fixes and enhancements (platform specific code)
Message-ID: <1276076345-24370-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series includes various fixes to sdhci-s3c driver as well as a
major feature enhancement. This patch series is prepared to get complete
sdhci support on Samsung Aquila board.

A quick overview on the patches:

#1 - trivial compilation break fix
#2 - add support for various methods of notifying the host driver about
     the card insertion/removal (should be compatible with existing code)
#3 - add sdhci driver platform data for all hsmmc controllers on Samsung
     Aquila board

Changes to the sdhci-s3c driver itself will be posted in a separate
patch series for easier merging, please refer to the "[PATCH] SDHCI-S3C
fixes and enhancements (driver specific code)" thread.

A complete list of patches:

[PATCH 1/3] s3c64xx: Fix build without SDHCI controllers
[PATCH 2/3] Samsung: sdhci-s3c: add support for new card detection methods
[PATCH 3/3] s5pv210: Aquila: add definitions for sdhci devices

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
