From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Tue, 16 Sep 2014 01:12:53 +0800
Subject: [Patch net-next 0/4] net: fec: add interrupt coalescence
Message-ID: <1410801177-15872-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

improve error handle when parse queue number.
add interrupt coalescence feature.

Frank Li (1):
  net: fec: refine error handle of parser queue number from DT

Fugang Duan (3):
  net: fec: add interrupt coalescence feature support
  net:fec: increase DMA queue number
  net: fec: Workaround for imx6sx enet tx hang when enable three queues

 drivers/net/ethernet/freescale/fec.h      |  16 +++-
 drivers/net/ethernet/freescale/fec_main.c | 144 ++++++++++++++++++++++++++++--
 2 files changed, 150 insertions(+), 10 deletions(-)

-- 
1.9.1
