From: moinejf@free.fr (Jean-Francois Moine)
Date: Thu, 10 Mar 2016 11:35:36 +0100
Subject: [PATCH 0/5] dmaengine: sun6i: Fixes and upgrade for audio transfers
Message-ID: <cover.1457606136.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series contains the required fixes and changes to the sun6i
DMA driver for audio streaming.
These ones have been tested in a Allwinner H3 (Orange PI 2).

Jean-Francois Moine (5):
  dmaengine: sun6i: Fix the access of the IRQ register
  dmaengine: sun6i: Fix impossible settings of burst and bus width
  dmaengine: sun6i: Add 4 as a possible bust value
  dmaengine: sun6i: Set default values to burst and bus width
  dmaengine: sun6i: Add cyclic capability

 drivers/dma/sun6i-dma.c | 180 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 161 insertions(+), 19 deletions(-)

-- 
2.7.2
