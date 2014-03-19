From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 20 Mar 2014 00:15:43 +0200
Subject: [PATCH 0/2] Disable subpage write for k2hk-evm
Message-ID: <1395267345-27795-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches disable subpage write for k2hk-evm.

Based on linux-next
tag: next-20140319

Ivan Khoronzhuk (2):
  mtd: davinci-nand: add dts property for NAND_NO_SUBPAGE_WRITE option
  ARM: dts: keystone: disable subpage write for davinci nand device

 Documentation/devicetree/bindings/mtd/davinci-nand.txt | 2 ++
 arch/arm/boot/dts/k2hk-evm.dts                         | 1 +
 drivers/mtd/nand/davinci_nand.c                        | 3 +++
 3 files changed, 6 insertions(+)

-- 
1.8.3.2
