From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Fri, 28 Nov 2014 15:08:02 +0100
Subject: [PATCH v3 0/4] mmc: atmel-mci: cleanup and probe deferring
Message-ID: <1417183686-31481-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ulf,

I have rebased my series on your next branch but I didn't have any conflict and
a warning on the whole series with checkpatch so please tell me if something
goes wrong.

Regards

Ludovic

Ludovic Desroches (4):
  mmc: atmel-mci: remove useless DMA stuff for non-dt devices
  mmc: atmel-mci: remove __init/__exit attributes
  mmc: atmel-mci: stop using specific initcall
  mmc: atmel-mci: use probe deferring if dma controller is not ready yet

 drivers/mmc/host/atmel-mci.c | 76 +++++++++++++++++---------------------------
 1 file changed, 29 insertions(+), 47 deletions(-)

-- 
2.0.3
