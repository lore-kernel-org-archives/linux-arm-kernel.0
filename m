From: tony@atomide.com (Tony Lindgren)
Date: Thu, 11 Nov 2010 17:03:20 -0800
Subject: [PATCH 0/4] omap fixes for v2.6.37-rc1
Message-ID: <20101112010245.3827.75329.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are few fixes for review.

Regards,

Tony

---

Felipe Balbi (1):
      arm: omap1: devices: need to return with a value

Janusz Krzysztofik (1):
      OMAP1: camera.h: add missing include

Mathias Nyman (1):
      omap: dma: Add read-back to DMA interrupt handler to avoid spuriousinterrupts

Thomas Weber (1):
      OMAP2: Devkit8000: Fix mmc regulator failure


 arch/arm/mach-omap1/devices.c             |    5 ++---
 arch/arm/mach-omap1/include/mach/camera.h |    2 ++
 arch/arm/mach-omap2/board-devkit8000.c    |    3 ---
 arch/arm/plat-omap/dma.c                  |    2 ++
 4 files changed, 6 insertions(+), 6 deletions(-)

-- 
Signature
