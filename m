From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Wed,  2 Sep 2015 00:54:12 +0530
Subject: [PATCH 0/2] mmc: sdhci-pxav3: Fix tabbing issue
Message-ID: <1441135454-6902-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial patch-series, which fixes the tabbing issue in the driver
and second patch prints the return value from sdhci_add_host() function


Vaibhav Hiremath (2):
  mmc: sdhci-pxav3: Fix tabbing issue
  mmc: sdhci-pxav3: Print ret value on error from sdhci_add_host() fn

 drivers/mmc/host/sdhci-pxav3.c | 65 ++++++++++++++++++++++--------------------
 1 file changed, 34 insertions(+), 31 deletions(-)

-- 
1.9.1
