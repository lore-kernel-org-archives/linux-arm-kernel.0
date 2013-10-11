From: b32955@freescale.com (Huang Shijie)
Date: Fri, 11 Oct 2013 18:30:57 +0800
Subject: [PATCH 0/4] serail: imx: patches for DMA 
Message-ID: <1381487461-12850-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After i tested the DMA for uart with the Bluetooth. I found several small
places need to be fixed.

The patch set contains several fixes for the DMA support.

Huang Shijie (4):
  serial: imx: implement the flush_buffer hook
  serial: imx: check the DMA for imx_tx_empty
  serial: imx: fix the wrong number of scatterlist entries when
    xmit->head is 0
  serial: imx: use the dmaengine_tx_status

 drivers/tty/serial/imx.c |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

-- 
1.7.2.rc3
