From: sergio.prado@e-labworks.com (Sergio Prado)
Date: Fri,  9 Dec 2016 11:14:42 -0200
Subject: [PATCH v2 0/2] mmc: host: s3cmci: add device tree support
Message-ID: <1481289284-19919-1-git-send-email-sergio.prado@e-labworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for configuring Samsung's S3C24XX MMC/SD/SDIO
controller via device tree.

Tested on FriendlyARM mini2440, based on s3c2440 SoC.

Changes since v1:
- pinctrl description removed from DT binding
- unit and label on DT binding renamed to mmc

Sergio Prado (2):
  dt-bindings: mmc: add DT binding for S3C24XX MMC/SD/SDIO controller
  mmc: host: s3cmci: allow probing from device tree

 .../devicetree/bindings/mmc/samsung,s3cmci.txt     |  34 +++++
 drivers/mmc/host/s3cmci.c                          | 155 +++++++++++++++++----
 2 files changed, 165 insertions(+), 24 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/samsung,s3cmci.txt

-- 
1.9.1
