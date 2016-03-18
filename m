From: moinejf@free.fr (Jean-Francois Moine)
Date: Fri, 18 Mar 2016 09:52:30 +0100
Subject: [PATCH v3 0/2] dmaengine: sun6i: Fixes
Message-ID: <cover.1458291150.git.moinejf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series replaces part of the previous series
'dmaengine: sun6i: Fixes and upgrade for audio transfers'.
It contains only fixes for a normal use of the DMA driver.

Changes since v2
- Acked-by Maxime Ripard added
- remove the audio requirements
Changes since v1 (comments from Vinod Koul and Sergei Shtylyov - thanks)
- typo fixes
- change some comments
- better handling of burst and bus width
- remove useless code in the cyclic capability patch

Jean-Francois Moine (2):
  dmaengine: sun6i: Fix the access of the IRQ register
  dmaengine: sun6i: Fix impossible settings of burst and bus width

 drivers/dma/sun6i-dma.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.7.4
