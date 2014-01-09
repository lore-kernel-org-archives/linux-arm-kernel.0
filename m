From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 9 Jan 2014 11:04:39 +0800
Subject: [PATCH 0/2] serial: fsl_lpuart: add eDMA support
Message-ID: <1389236681-30372-1-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Changed in v2:
- Add eDMA support for lpuart receive.
- Use dma_map_single in a right way.
- Use dma_mapping_error test dma_map_single.
- Change some names of variable.
- Fix some bugs.

Added in v1:
- Add device tree bindings for lupart eDMA support.
- Add eDMA support for lpuart send.
