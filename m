From: Ramiro.Oliveira@synopsys.com (Ramiro Oliveira)
Date: Wed, 14 Dec 2016 17:18:22 +0000
Subject: [PATCH 0/2] xilinx_dma: Add external reset control
Message-ID: <cover.1481735244.git.roliveir@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for controlling an external reset line. Since
this reset line is optional it won't break compatibility.

Ramiro Oliveira (2):
  xilinx_dma: Edit device tree bindings documentation
  xilinx_dma: Add reset support

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |  6 ++++++
 drivers/dma/xilinx/xilinx_dma.c                    | 23 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)

-- 
2.10.2
