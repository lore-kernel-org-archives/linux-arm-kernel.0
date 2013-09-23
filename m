From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 24 Sep 2013 00:16:29 +0800
Subject: [PATCH 0/9] arm/dts: sirf: a bundle of fixed for prima2 and atlas6
Message-ID: <1379952998-16393-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

here it is a bundle of dts fixes for prima2, atlas6. it adds missed prop or node,
fixes the memory ranges, fixes interrupt number, fixes dma channels etc.

Barry Song (4):
  arm/dts: sirf: add missed chhifbg node in prima2 and atlas6 dts
  arm/dts: sirf: add missed cell, cs and dma channel for SPI nodes
  arm/dts: makefile: build atlas6-evb.dtb for ARCH_ATLAS6
  arm/dts: sirf: fix the ranges of peri-iobrg of prima2

Jiansong Chen (1):
  arm/dts: sirf: add missed graphics2d iobg in atlas6 dts

Qipan Li (1):
  arm/dts: sirf: fix fifosize, clks, dma channels for UART

Renwei Wu (2):
  arm/dts: sirf: add missed address-cells and size-cells for prima2 I2C
  arm/dts: sirf: fix interrupt and dma prop of VIP for prima2 and atlas6

Ye He (1):
  arm/dts: sirf: add missed memcontrol-monitor node in prima2 and atlas6
    dts

 arch/arm/boot/dts/Makefile    |  2 ++
 arch/arm/boot/dts/atlas6.dtsi | 45 +++++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/prima2.dtsi | 57 +++++++++++++++++++++++++++++++++++++++----
 3 files changed, 98 insertions(+), 6 deletions(-)

-- 
1.8.2.3
