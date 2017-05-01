From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 1 May 2017 21:26:17 +0200
Subject: [PATCH 0/3] SoC-TI-knav_dma: Fine-tuning for three function
 implementations
Message-ID: <eddc35f7-a04b-42f5-ad8b-d345ca0b57b4@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 1 May 2017 21:21:42 +0200

Three update suggestions were taken into account
from static source code analysis.

Markus Elfring (3):
  Use seq_putc() in dma_debug_show_channels()
  Improve a size determination in knav_dma_probe()
  Delete error messages for a failed memory allocation in two functions

 drivers/soc/ti/knav_dma.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

-- 
2.12.2
