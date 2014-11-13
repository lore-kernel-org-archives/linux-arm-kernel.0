From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Thu, 13 Nov 2014 15:14:54 +0100
Subject: [PATCH 0/2] at_xdmac update for generic slave capabilities
Message-ID: <1415888096-22090-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Please add this update of the at_xdmac driver to the "Implement generic slave
capabilities retrieval" set of patches.

Tell me if something missing.

Ludovic Desroches (2):
  dmaengine: at_xdmac: correct destination abbreviation
  dmaengine: at_xdmac: split device_control

 drivers/dma/at_xdmac.c | 96 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 58 insertions(+), 38 deletions(-)

-- 
2.0.3
