From: Frank.Li@freescale.com (Frank.Li at freescale.com)
Date: Wed, 17 Sep 2014 01:58:06 +0800
Subject: [Patch net-next v2 0/4] net: fec: add interrupt coalescence
Message-ID: <1410890290-11248-1-git-send-email-Frank.Li@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>

improve error handle when parse queue number.
add interrupt coalescence feature.

Change from v1 to v2
 - fix indention
 - use errata number instead of TKT

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
