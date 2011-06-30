From: b32955@freescale.com (Huang Shijie)
Date: Thu, 30 Jun 2011 11:53:45 +0800
Subject: [PATCH v5 0/3] add the GPMI-NFC support for imx23/imx28
Message-ID: <1309406028-2924-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch is based on branch "imx-for-3.1" of tree :
      git://git.pengutronix.de/git/imx/linux-2.6.git

v4 --> v5:
	[0] split out the mach code and the machine code.

v3 --> v4:
	merge the GPMI-NFC device code to the new branch.

Huang Shijie (3):
  ARM: mxs: add GPMI-NFC support for imx23/imx28
  ARM: mxs/mx23evk: add GPMI-NFC device
  ARM: mxs/mx28evk: add GPMI-NFC device

 arch/arm/mach-mxs/Kconfig                       |    2 +
 arch/arm/mach-mxs/clock-mx23.c                  |    1 +
 arch/arm/mach-mxs/clock-mx28.c                  |    1 +
 arch/arm/mach-mxs/devices-mx23.h                |    4 +
 arch/arm/mach-mxs/devices-mx28.h                |    4 +
 arch/arm/mach-mxs/devices/Kconfig               |    3 +
 arch/arm/mach-mxs/devices/Makefile              |    1 +
 arch/arm/mach-mxs/devices/platform-gpmi-nfc.c   |   90 +++++++++++++++++++++++
 arch/arm/mach-mxs/include/mach/devices-common.h |   10 +++
 arch/arm/mach-mxs/include/mach/gpmi-nfc.h       |   71 ++++++++++++++++++
 arch/arm/mach-mxs/mach-mx23evk.c                |   37 +++++++++
 arch/arm/mach-mxs/mach-mx28evk.c                |   37 +++++++++
 12 files changed, 261 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-mxs/devices/platform-gpmi-nfc.c
 create mode 100644 arch/arm/mach-mxs/include/mach/gpmi-nfc.h
