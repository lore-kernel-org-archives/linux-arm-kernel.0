From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 6 Jan 2017 00:06:22 +0800
Subject: [PATCH 0/2] media: rc: add support for IR receiver on MT7623 SoC
Message-ID: <1483632384-8107-1-git-send-email-sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

This patchset introduces Consumer IR (CIR) support for MT7623 SoC 
or other similar SoC and implements raw mode for more compatibility
with different protocols. The driver simply reports the duration of 
pulses and spaces to rc core logic to decode.

Sean Wang (2):
  Documentation: devicetree: Add document bindings for mtk-cir
  media: rc: add driver for IR remote receiver on MT7623 SoC

 .../devicetree/bindings/media/mtk-cir.txt          |  23 ++
 drivers/media/rc/Kconfig                           |  10 +
 drivers/media/rc/Makefile                          |   1 +
 drivers/media/rc/mtk-cir.c                         | 319 +++++++++++++++++++++
 4 files changed, 353 insertions(+)
 create mode 100644 linux-4.8.rc1_p0/Documentation/devicetree/bindings/media/mtk-cir.txt
 create mode 100644 linux-4.8.rc1_p0/drivers/media/rc/mtk-cir.c

-- 
1.9.1
