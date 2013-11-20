From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Wed, 20 Nov 2013 17:46:54 +0200
Subject: [PATCH 0/2] Introduce AEMIF driver for Davinci/Keystone archs
Message-ID: <1384962416-14862-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches introduce Async External Memory Interface (EMIF16/AEMIF)
controller driver for Davinci/Keystone archs.

V1:
https://lkml.org/lkml/2013/11/11/352

Ivan Khoronzhuk (2):
  memory: ti-aemif: introduce AEMIF driver
  memory: ti-aemif: add bindings for AEMIF driver

 .../bindings/memory-controllers/ti-aemif.txt       |  198 ++++++++++
 drivers/memory/Kconfig                             |   11 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/ti-aemif.c                          |  415 ++++++++++++++++++++
 4 files changed, 625 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt
 create mode 100644 drivers/memory/ti-aemif.c

-- 
1.7.9.5
