From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 17 Jan 2011 22:39:22 +0800
Subject: A couple of trivial fix on imx-sdma
Message-ID: <1295275164-7824-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm studying imx-sdma code to implement mxs dma engine.  The patch
set is to fix a couple trivial problems seen in the study.

  [PATCH 1/2] dmaengine: imx-sdma: fix return of sdma_probe()
  [PATCH 2/2] dmaengine: imx-sdma: fix inconsistent naming in sdma_assign_cookie()

Regards,
Shawn
