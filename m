From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 26 Nov 2014 17:22:26 +0100
Subject: [PATCH 0/3] dmaengine: at_xdmac: several improvements
Message-ID: <1417018949-24246-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series is based on Vinod's next branch plus Maxime Ripard's series:
"[PATCH v5 00/61] dmaengine: Implement generic slave capabilities retrieval"

Cyrille Pitchen (1):
  dmaengine: at_xdmac: wait for in-progress transaction to complete
    after     pausing a channel

Ludovic Desroches (2):
  dmaengine: at_xdmac: simplify channel configuration stuff
  dmaengine: at_xdmac: allow muliple dwidths when doing slave transfers

 drivers/dma/at_xdmac.c | 51 ++++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 24 deletions(-)

-- 
2.0.3
