From: Barry.Song@csr.com (Barry Song)
Date: Mon, 18 Mar 2013 15:04:37 +0800
Subject: [PATCH 0/2] arm: prima2: add support for CSR SiRFatlas6 SoC
Message-ID: <1363590279-5656-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SiRFatlas6 is much similar with SiRFprimaII with some changes about:
1. deleted l2 cache, sdmmc4, multimedia and so on
2. changed pinmux layout and clock layout
3. DMA access limitation disappears, that makes us not need DMA_ZONE
   on atlas6

Barry Song (2):
  arm: prima2: add new SiRFatlas6 machine in common board
  ARM/dts: prima2: add .dtsi for atlas6 and .dts for atla6-evb board

 arch/arm/boot/dts/atlas6-evb.dts |   78 +++++
 arch/arm/boot/dts/atlas6.dtsi    |  668 ++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-prima2/Kconfig     |   10 +-
 arch/arm/mach-prima2/common.c    |   21 ++
 4 files changed, 776 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/boot/dts/atlas6-evb.dts
 create mode 100644 arch/arm/boot/dts/atlas6.dtsi

-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
