From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 23 Feb 2016 14:04:34 +0800
Subject: [PATCH v2 0/2] ARM: at91: sama5/dts: move hsmc_clk out of nfc node
Message-ID: <1456207477-7946-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For SAMA5D3, SAMA5D4 SoC family, PMECC needs the HSMC clock,
so move out hsmc_clk from the nfc node to the nand node.

Also, change the SAMA5D3 nand node's compatible string to
"atmel,sama5d3-nand".

Changes in v2:
 - add a patch to change SAMA5D3 nand node's compatible string
   to "atmel,sama5d3-nand".
 - revert the mail address of Josh's Signed-off to the original.

Josh Wu (2):
  ARM: at91: sama5d3/dts: add compatiable string for nand
  ARM: at91: sama5/dts: move hsmc_clk out of nfc node

 arch/arm/boot/dts/sama5d3.dtsi |    4 ++--
 arch/arm/boot/dts/sama5d4.dtsi |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

-- 
1.7.9.5
