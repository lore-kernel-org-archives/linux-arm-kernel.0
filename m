From: cb@sgoc.de (Christoph G. Baumann)
Date: Tue, 23 Apr 2013 14:11:23 +0200
Subject: [PATCH 0/2] Support fsl-dcp crypto coprocessor
In-Reply-To: <1366710460-11637-1-git-send-email-cb@sgoc.de>
References: <1366710460-11637-1-git-send-email-cb@sgoc.de>
Message-ID: <1366719085-12847-1-git-send-email-cb@sgoc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Christoph G. Baumann" <c.baumann@ppc-ag.de>


Forgot some changed files in the first try...

The following patch is a port of the original driver from Freescale to
the current mainline. The patch was tested under 3.7.

Christoph G. Baumann (2):
  Support fsl-dcp crypto coprocessor
  Support fsl-dcp crypto coprocessor

 arch/arm/boot/dts/imx28.dtsi                 |    2 +-
 drivers/staging/Kconfig                      |    2 +
 drivers/staging/Makefile                     |    1 +
 drivers/staging/crypto/Kconfig               |   15 +
 drivers/staging/crypto/Makefile              |    1 +
 drivers/staging/crypto/fsl-dcp.c             | 1817 ++++++++++++++++++++++++++
 drivers/staging/crypto/fsl-dcp.h             |  739 +++++++++++
 include/linux/fsl/fsl-dcp_bootstream_ioctl.h |   32 +
 8 files changed, 2608 insertions(+), 1 deletion(-)
 create mode 100644 drivers/staging/crypto/Kconfig
 create mode 100644 drivers/staging/crypto/Makefile
 create mode 100644 drivers/staging/crypto/fsl-dcp.c
 create mode 100644 drivers/staging/crypto/fsl-dcp.h
 create mode 100644 include/linux/fsl/fsl-dcp_bootstream_ioctl.h

-- 
1.7.9.5
