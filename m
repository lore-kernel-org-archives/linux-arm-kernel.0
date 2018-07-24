From: Sven.Schmitt@mixed-mode.de (Sven Schmitt)
Date: Tue, 24 Jul 2018 09:46:01 +0000
Subject: [PATCH v3 0/3] soc: imx: gpc: cleanups
Message-ID: <1532425557359.10004@mixed-mode.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes the power down delay in gpc.c 
and improves readability.

Changes in v3:
* rebased to 4.18
* split up patch into 3 parts

Changes in v2:
* dropped cntr_pup_bit

Sven Schmitt (3):
  soc: imx: gpc: fix PDN delay
  soc: imx: gpc: clean up
  soc: imx: gpc: use GPC_PGC_DOMAIN_* indexes

 drivers/soc/imx/gpc.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

-- 
2.17.1
