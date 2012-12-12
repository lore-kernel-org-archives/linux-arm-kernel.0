From: fabio.baltieri@linaro.org (Fabio Baltieri)
Date: Wed, 12 Dec 2012 10:37:14 +0100
Subject: [PATCH 0/7] various ste_dma40 fixes
Message-ID: <1355305041-2338-1-git-send-email-fabio.baltieri@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

this patch set contains some fixes for the ste_dma40 driver.

Thanks,
Fabio


Gerald Baeza (1):
  dmaengine: ste_dma40: support fixed physical channel allocation

Narayanan (1):
  dmaengine: ste_dma40: reset priority bit for logical channels

Narayanan G (1):
  dmaengine: ste_dma40: don't check for pm_runtime_suspended()

Per Forlin (3):
  dmaengine: ste_dma40: use writel_relaxed for lcxa
  dmaengine: ste_dma40: set dma max seg size
  dmaengine: ste_dma40: limit burst size to 16

Rabin Vincent (1):
  dmaengine: ste_dma40: don't allow high priority dest event lines

 drivers/dma/ste_dma40.c    | 46 +++++++++++++++++++++++++++++++++++++++++-----
 drivers/dma/ste_dma40_ll.c | 27 ++++++++++++++-------------
 2 files changed, 55 insertions(+), 18 deletions(-)

-- 
1.7.12.1
