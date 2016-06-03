From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Fri,  3 Jun 2016 19:47:11 +0000
Subject: [PATCH 0/2] mmc: remove sdhci-bcm2835
Message-ID: <1464983233-27001-1-git-send-email-stefan.wahren@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdhci-bcm2835 is no more needed since it has been replaced
by sdhci-iproc.

Stefan Wahren (2):
  DT: bindings: remove bcm2835-sdhci
  mmc: sdhci-bcm2835: remove driver

 .../devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt |   18 --
 drivers/mmc/host/Kconfig                           |   11 --
 drivers/mmc/host/Makefile                          |    1 -
 drivers/mmc/host/sdhci-bcm2835.c                   |  204 --------------------
 4 files changed, 234 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm2835-sdhci.txt
 delete mode 100644 drivers/mmc/host/sdhci-bcm2835.c

-- 
1.7.9.5
