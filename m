From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Thu,  1 Dec 2016 22:14:23 -0200
Subject: [PATCH 0/2] mmc: host: s3cmci: add device tree support
Message-ID: <1480637665-6325-1-git-send-email-sergio.prado@e-labworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for configuring Samsung's S3C24XX MMC/SD/SDIO
controller via device tree.

Tested on FriendlyARM mini2440, based on s3c2440 SoC.

Sergio Prado (2):
  dt-bindings: mmc: add DT binding for S3C24XX MMC/SD/SDIO controller
  mmc: host: s3cmci: allow probing from device tree

 .../devicetree/bindings/mmc/samsung,s3cmci.txt     |  38 +++++
 drivers/mmc/host/s3cmci.c                          | 155 +++++++++++++++++----
 2 files changed, 169 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt

-- 
1.9.1
