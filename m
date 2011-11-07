From: sangwook.lee@linaro.org (Sangwook Lee)
Date: Mon,  7 Nov 2011 17:05:20 +0000
Subject: [PATCH 0/2] ARM: SAMSUNG: Add pm_caps 
Message-ID: <1320685522-17481-1-git-send-email-sangwook.lee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pm_caps into platform data and update it in SD/MMC driver
This field can be used with SDIO device such as SDIO WLAN.

Sangwook Lee (2):
  ARM: SAMSUNG: Add pm_caps into platform data
  mmc: sdhci-s3c: Add pm_caps into SD/MMC host

 arch/arm/plat-samsung/dev-hsmmc3.c         |    2 ++
 arch/arm/plat-samsung/include/plat/sdhci.h |    2 ++
 drivers/mmc/host/sdhci-s3c.c               |    3 +++
 3 files changed, 7 insertions(+), 0 deletions(-)

-- 
1.7.4.1
