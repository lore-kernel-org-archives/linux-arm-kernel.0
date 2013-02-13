From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 13 Feb 2013 08:13:22 -0300
Subject: [RFC 0/1] ARM: omap2: gpmc: Move binding documentation
Message-ID: <1360754003-3988-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Following current trend of placing memory controllers drivers under
drivers/memory, this patch anticipates this by moving the binding
documentation to Documentation/devicetree/bindings/memory-controller.

Some other SoCs will have similar memory controllers placed under
drivers/memory and it seems a bit strange to put GPMC under drivers/bus.

Ezequiel Garcia (1):
  ARM: omap2: gpmc: Move binding documentation to memory-controller

 .../ti-gpmc.txt => memory-controllers/ti/gpmc.txt} |    0
 1 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{bus/ti-gpmc.txt => memory-controllers/ti/gpmc.txt} (100%)

-- 
1.7.8.6
