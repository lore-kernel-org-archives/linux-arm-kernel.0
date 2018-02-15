From: tali.perry1@gmail.com (Tali Perry)
Date: Thu, 15 Feb 2018 15:39:18 +0200
Subject: [PATCH v2 0/1] *clk: npcm750: add clock header to patch,
 fix typos and content in dt-binding txt
Message-ID: <1518701959-22899-1-git-send-email-tali.perry1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add Nuvoton BMC NPCM7xx clock driver.

Nuvoton BMC NPCM7xx contain integrated clock controller which
generates and supplies clock to all modules within the NPCM7xx BMC

1 ==> 2
This patch includes fix request described here:
https://lkml.org/lkml/2018/2/8/739
(add clock header to patch, fix typos and content in dt-binding txt)

Signed-off-by: Tali Perry <tali.perry1@gmail.com>

Tali Perry (1):
  clk: npcm750: update text with fixed clocks

 .../bindings/clock/nuvoton,npcm750-clk.txt         | 103 +++++++++++++++++++++
 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h  |  51 ++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm750-clk.txt
 create mode 100644 include/dt-bindings/clock/nuvoton,npcm7xx-clock.h

-- 
2.14.1
