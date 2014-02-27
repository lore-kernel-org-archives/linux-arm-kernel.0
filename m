From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 27 Feb 2014 14:05:13 +0800
Subject: [PATCH 0/3] i2c: add DMA support for freescale i2c driver
Message-ID: <1393481115-22136-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Added in v1:
- Enable dma if it's support dma and transfer size bigger than the threshold.
- Add device tree bindings for i2c eDMA support.
- Add eDMA support for i2c driver.
