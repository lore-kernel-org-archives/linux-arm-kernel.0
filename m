From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 13:59:51 +0100
Subject: [PATCH 0/2] Kirkwood RD88F6192 and RD88F6281 DT conversion
Message-ID: <1392469193-25883-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches convert two Marvell Reference designs from old style
setup files to DT. No testing has been performed other than that they
compile.

Andrew Lunn (2):
  ARM: Kirkwood: Add DT description of rd88f6192.
  ARM: Kirkwood: convert rd88f6281-setup.c to DT.

 arch/arm/boot/dts/Makefile                  |   3 +
 arch/arm/boot/dts/kirkwood-rd88f6192.dts    | 112 ++++++++++++++++++++
 arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts |  26 +++++
 arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts |  31 ++++++
 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi   | 152 ++++++++++++++++++++++++++++
 5 files changed, 324 insertions(+)
 create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6192.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a0.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281-a1.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-rd88f6281.dtsi

-- 
1.8.5.3
