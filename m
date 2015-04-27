From: manabian@gmail.com (Joachim Eastwood)
Date: Tue, 28 Apr 2015 00:30:41 +0200
Subject: [PATCH 0/2] reset driver for NXP LPC18xx family
Message-ID: <1430173843-11648-1-git-send-email-manabian@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds a reset driver for NXP LPC18xx/43xx devices.

There are no dependencies in this patch set. The DTS changes will
be sent separately to arm-soc once this patch set goes upstream.

Base support for the NXP LPC18xx family can be found here:
http://marc.info/?l=linux-arm-kernel&m=143016894704253&w=2

Joachim Eastwood (2):
  reset: add driver for lpc18xx rgu
  doc: dt: add documentation for lpc1850-rgu reset driver

 .../devicetree/bindings/reset/nxp,lpc1850-rgu.txt  |  38 +++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-lpc18xx.c                      | 260 +++++++++++++++++++++
 3 files changed, 299 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/nxp,lpc1850-rgu.txt
 create mode 100644 drivers/reset/reset-lpc18xx.c

-- 
1.8.0
