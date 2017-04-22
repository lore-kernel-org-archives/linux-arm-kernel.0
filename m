From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 22 Apr 2017 23:23:03 +0200
Subject: [PATCH 0/2] dmaengine: s3c24xx: Fine-tuning for s3c24xx_dma_probe()
Message-ID: <930f0a6c-bc5c-3d01-6814-563780fc90ef@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 22 Apr 2017 23:14:32 +0200

Two update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  Use devm_kcalloc() in s3c24xx_dma_probe()
  Fix a typo in a comment line

 drivers/dma/s3c24xx-dma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

-- 
2.12.2
