From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 18 Apr 2014 14:44:24 +0800
Subject: [PATCH v2 0/2] ahci: imx: software workaround for phy reset issue
Message-ID: <1397803466-28411-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
 - Do not switch to defines and stay with enums
 - Create a wrapper function imx_phy_crbit_assert() to make the code
   a little shorter and easier for eyes

Shawn Guo (2):
  ahci: imx: add namespace for register enums
  ahci: imx: software workaround for phy reset issue in resume

 drivers/ata/ahci_imx.c | 172 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 165 insertions(+), 7 deletions(-)

-- 
1.8.3.2
