From: tali.perry1@gmail.com (Tali Perry)
Date: Thu, 15 Feb 2018 15:41:54 +0200
Subject: [PATCH v2 0/1] clk: npcm: move fixed clocks to DT
Message-ID: <1518702115-22990-1-git-send-email-tali.perry1@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixed clocks defined at driver/clk/clk-npcm7xx.c moved to DT. 

1 ==> 2
This patch includes fix request described here:
https://patchwork.kernel.org/patch/10200033/
(move fixed clocks to DT)

Signed-off-by: Tali Perry <tali.perry1@gmail.com>

Tali Perry (1):
  npcm750: add fixed clocks (moved from drivers/clk/clk-npcm7xx.c)

 arch/arm/boot/dts/nuvoton-npcm750.dtsi | 1223 ++++++++++++++++++++++++++++++++
 1 file changed, 1223 insertions(+)
 create mode 100644 arch/arm/boot/dts/nuvoton-npcm750.dtsi

-- 
2.14.1
