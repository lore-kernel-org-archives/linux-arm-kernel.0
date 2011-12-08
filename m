From: LW@KARO-electronics.de (=?utf-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu,  8 Dec 2011 09:17:43 +0100
Subject: [MXS MMC v2 0/4] Some cleanups and fixes for the MXS MMC subsystem
Message-ID: <cover.1323328267.git.LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lothar Wa??mann (4):
  Fix grammatical error in comment
  Some cleanups for the MMC driver
  Check the return codes of clk_enable() and mxs_reset_block()
  Add an appropriate MODULE_ALIAS

Changes wrt v1:
 - omitted patch 3 "Add support for MMC ports 2 & 3" which has already
   been applied by Shawn Guo
 - fix checkpatch warnings in patch 2 and leave indentation as is
 - add Acked-by: where applicable

 drivers/mmc/host/mxs-mmc.c |   87 +++++++++++++++++++++++++++------------------
 1 file changed, 54 insertions(+), 33 deletions(-)
