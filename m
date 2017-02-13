From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 13 Feb 2017 16:31:47 +0100
Subject: [PATCH v1] nvmem: i.MX IIM driver
Message-ID: <20170213153149.11710-1-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This adds a readonly nvmem driver for the i.MX IC Identification Module (IIM)
which is found on the older i.MX SoCs. The IIM is part of the i.MX dts files
for long now, but so far there is no binding document for it, so add one now.

Sascha

----------------------------------------------------------------
Michael Grzeschik (1):
      nvmem: Add driver for the i.MX IIM

Sascha Hauer (1):
      dt-bindings: nvmem: Add i.MX IIM binding doc

 .../devicetree/bindings/nvmem/imx-iim.txt          |  22 +++
 drivers/nvmem/Kconfig                              |  11 ++
 drivers/nvmem/Makefile                             |   2 +
 drivers/nvmem/imx-iim.c                            | 171 +++++++++++++++++++++
 4 files changed, 206 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/imx-iim.txt
 create mode 100644 drivers/nvmem/imx-iim.c
