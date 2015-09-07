From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon,  7 Sep 2015 17:01:08 +0530
Subject: [PATCH-v2 0/3] mmc: sdhci-pxav3: Fix tabbing issue
Message-ID: <1441625471-16315-1-git-send-email-vaibhav.hiremath@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial patch-series, which fixes the tabbing issue in the driver,
uses the BIT macro for bit fields and prints notice on -EPROBE_DEFER
in sdhci_add_host() function on regulator unavailability.

V1 => V2
========
 - Fixed all comments from Joe, mostly alignment changes
 - Separated BIT macro usage patch into new one.
 - changed error to kernel notice for EPROBE_DEFER in sdhci_add_host()

Note: This patch-series should get merged before another series -

[PATCH-v2 0/7] mmc: sdhci-pxav3: Enable support for PXA1928 SDCHI controller

Vaibhav Hiremath (3):
  mmc: sdhci-pxav3: Fix tabbing issue
  mmc: sdhci-pxav3: Use BIT macro for bit field definitions
  mmc: sdhci: print notice on -EPROBE_DEFER in sdhci_add_host() fn

 drivers/mmc/host/sdhci-pxav3.c | 46 +++++++++++++++++++++---------------------
 drivers/mmc/host/sdhci.c       |  5 ++++-
 2 files changed, 27 insertions(+), 24 deletions(-)

-- 
1.9.1
