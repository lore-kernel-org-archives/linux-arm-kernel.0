From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 14 Feb 2011 10:23:45 +0800
Subject: [PATCH v2 0/3] Add dma support for i.MX23/28
Message-ID: <1297650228-12762-1-git-send-email-shawn.guo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The v2 of the patch set is to address the v1 comments given by
Russell, Sascha, and Lothar.

The patch number is down to 3 from 5 (v1) due to the change of dma
device dynamical allocation to the static.

  [PATCH v2 1/3] dmaengine: mxs-dma: add dma support for i.MX23/28
  [PATCH v2 2/3] ARM: mxs: add dma channel definitions
  [PATCH v2 3/3] ARM: mxs: add dma device

Thanks for review.

Regards,
Shawn
