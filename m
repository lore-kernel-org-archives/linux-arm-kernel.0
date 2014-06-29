From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Sun, 29 Jun 2014 22:50:20 +0200
Subject: [PATCH 0/1] ARM: dts: zynq: Prepare Parallella
Message-ID: <1404075022-28745-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch adds an initial device tree for the Parallella board.
UART, SD card, Ethernet are enabled.
Not yet enabled are HDMI (FPGA, ADV7513), QSPI and 2x USB.

Where I'm a bit unsure is the PHY placement; placement as subnode of the 
GEM corresponds to what was in the downstream 3.12 based device tree. It 
is a separate chip on the board though, whereas GEM is on the SoC.

Regards,
Andreas

Andreas F?rber (1):
  ARM: dts: zynq: Add Parallella device tree

 arch/arm/boot/dts/Makefile            |  4 ++-
 arch/arm/boot/dts/zynq-parallella.dts | 63 +++++++++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/zynq-parallella.dts

-- 
1.9.3
