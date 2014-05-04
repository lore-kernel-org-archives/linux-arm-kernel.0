From: shawn.guo@freescale.com (Shawn Guo)
Date: Sun, 4 May 2014 21:48:04 +0800
Subject: [PATCH v3 0/2] ahci: imx: software workaround for phy reset issue
Message-ID: <1399211286-8624-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
 - Have comment for register definition
 - Use IMX_ instead of IMX_SATA_ for prefix to make it a bit shorter

Shawn Guo (2):
  ahci: imx: add namespace for register enums
  ahci: imx: software workaround for phy reset issue in resume

 drivers/ata/ahci_imx.c | 177 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 170 insertions(+), 7 deletions(-)

-- 
1.8.3.2
