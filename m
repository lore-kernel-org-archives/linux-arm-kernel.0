From: andrew@lunn.ch (Andrew Lunn)
Date: Mon,  4 Apr 2016 23:53:10 +0200
Subject: [PATCH v5 0/2] Add ZII development board.
Message-ID: <1459806792-7729-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rather than list empty DMA properties, this version includes an
additional patch adding quirks to the serial driver, and disabling DMA
when the vybrid compatibility string is seen.

Andrew Lunn (1):
  serial: fsl_lpuart: Add DMA quirk

Cory Tusar (1):
  ARM: dts: vf610-zii-dev: Add ZII development board.

 arch/arm/boot/dts/Makefile                |   3 +-
 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts | 736 ++++++++++++++++++++++++++++++
 drivers/tty/serial/fsl_lpuart.c           |  36 +-
 3 files changed, 764 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/boot/dts/vf610-zii-dev-rev-b.dts

-- 
2.7.0
