From: Ramiro.Oliveira@synopsys.com (Ramiro Oliveira)
Date: Mon,  6 Mar 2017 12:17:37 +0000
Subject: [PATCH v2 0/2] xilinx_dma: Add external reset control
Message-ID: <cover.1488801913.git.roliveir@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for controlling an external reset line. Since
this reset line is optional it won't break compatibility.

v2:
 - Re-order headers
 - Remove deprecated function
 - Remove reset naming

Ramiro Oliveira (2):
  dma: xilinx: Edit device tree bindings documentation
  dma: xilinx: Add reset support

 .../devicetree/bindings/dma/xilinx/xilinx_dma.txt  |  2 ++
 drivers/dma/xilinx/xilinx_dma.c                    | 24 ++++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.11.0
