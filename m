From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 13 Jun 2013 18:39:17 +0530
Subject: [PATCH 0/3] minor omap dma fixes
Message-ID: <1371128960-24822-1-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Here are some minor omap dma fixes.

R Sricharan (2):
  ARM: OMAP: dma: Remove the wrong dev_id check
  ARM: OMAP: dma: Fix the dma_chan_link_map init order

Rajendra Nayak (1):
  ARM: OMAP: dma: Fix the kfree ordering

 arch/arm/plat-omap/dma.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
1.7.9.5
