From: jingchang.lu@freescale.com (Jingchang Lu)
Date: Fri, 11 Jul 2014 13:41:40 +0800
Subject: [PATCH 0/2] tty: serial: fsl_lpuart: add 32-bit register support and
 dt-binding
Message-ID: <1405057302-26041-1-git-send-email-jingchang.lu@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This two patches change the fsl-lpuart dt-binding to exact SoC product revision
and add 32-bit big-endian register interface support which can be found on
Freescale LS1021A SoC platform.

----------------------------------------------------------------
Jingchang Lu (2):
	dt-binding: fsl-lpuart: use exact SoC revision to document binding
	tty: serial: fsl_lpuart: add 32-bit register interface support

 Documentation/devicetree/bindings/serial/fsl-lpuart.txt |   6 +-
 drivers/tty/serial/fsl_lpuart.c                         | 653 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 648 insertions(+), 11 deletions(-)
