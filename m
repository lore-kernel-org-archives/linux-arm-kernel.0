From: antoine.tenart@free-electrons.com (=?UTF-8?q?Antoine=20T=C3=A9nart?=)
Date: Wed, 12 Mar 2014 12:06:02 +0100
Subject: [PATCH 0/2] ARM: add initial support for the Marvell BG2-Q DMP
Message-ID: <1394622364-6848-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie adds the initial support for the Marvell BG2-Q DMP (part of the
Berlin family). SoC has nodes for cpu, l2 cache controller, interrupt
controllers, local timer, apb timers and uarts for now.

Homepage: http://www.marvell.com/digital-entertainment/armada-1500-pro/

Antoine T?nart (2):
  ARM: dts: berlin2q: add the Marvell Armada 1500 pro (BG2Q) device tree
  ARM: dts: berlin2q: add the Marvell BG2-Q DMP device tree

 Documentation/arm/Marvell/README                   |   5 +
 .../devicetree/bindings/arm/marvell,berlin.txt     |   1 +
 arch/arm/boot/dts/Makefile                         |   3 +-
 arch/arm/boot/dts/berlin2q-dmp.dts                 |  32 ++++
 arch/arm/boot/dts/berlin2q.dtsi                    | 167 +++++++++++++++++++++
 5 files changed, 207 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/berlin2q-dmp.dts
 create mode 100644 arch/arm/boot/dts/berlin2q.dtsi

-- 
1.8.3.2
