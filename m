From: cyrille.pitchen@atmel.com (Cyrille Pitchen)
Date: Mon, 15 Jun 2015 17:17:50 +0200
Subject: [PATCH linux-next 0/1] dmaengine: at_hdmac: fix residue computation
Message-ID: <cover.1434380729.git.cyrille.pitchen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ChangeLog

v1:
This patch fixes a bug reported by Jiri Prchal for the USART behaviour on
some Atmel SoCs when DMA is used to receive data. More generally, it fixes
the DMA residue computation.

Cyrille Pitchen (1):
  dmaengine: at_hdmac: fix residue computation

 drivers/dma/at_hdmac.c      | 47 ++++++++++++++++-----------------------------
 drivers/dma/at_hdmac_regs.h |  3 +--
 2 files changed, 18 insertions(+), 32 deletions(-)

-- 
1.8.2.2
