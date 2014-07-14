From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Mon, 14 Jul 2014 17:41:09 +0800
Subject: [PATCHv2 0/2] tty: serial: fsl_lpuart: add 32-bit register support
 and dt-binding
Message-ID: <1405330871-9038-1-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This two patches change the fsl-lpuart dt-binding to exact SoC product revision
and add 32-bit big-endian register interface support which can be found on
Freescale LS1021A SoC platform.

---
changes in v2:
Fix undifined lpuart32_reg error.

----------------------------------------------------------------
Jingchang Lu (2):
      dt-binding: fsl-lpuart: use exact SoC revision to document binding
      tty: serial: fsl_lpuart: add 32-bit register interface support

 Documentation/devicetree/bindings/serial/fsl-lpuart.txt |   6 +-
 drivers/tty/serial/fsl_lpuart.c                         | 645 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 642 insertions(+), 9 deletions(-)
