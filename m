From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 13 Mar 2014 09:47:55 +0800
Subject: [PATCH v3 0/2] i2c: add DMA support for freescale i2c driver
Message-ID: <1394675277-24913-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Changed in v3:
- fix a bug when request the dma faild.
- some minor fixes for coding style.
- other minor fixes.

Changed in v2:
- remove has_dma_support property
- unify i2c_imx_dma_rx and i2c_imx_dma_tx
- unify i2c_imx_dma_read and i2c_imx_pio_read
- unify i2c_imx_dma_write and i2c_imx_pio_write

Added in v1:
- Enable dma if it's support dma and transfer size bigger than the threshold.
- Add device tree bindings for i2c eDMA support.
- Add eDMA support for i2c driver.
