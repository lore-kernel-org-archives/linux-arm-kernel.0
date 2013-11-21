From: ivan.khoronzhuk@ti.com (Ivan Khoronzhuk)
Date: Thu, 21 Nov 2013 13:30:35 +0200
Subject: [PATCH v2 0/2] Introduce AEMIF driver for Davinci/Keystone archs
Message-ID: <1385033437-13235-1-git-send-email-ivan.khoronzhuk@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches introduce Async External Memory Interface (EMIF16/AEMIF)
controller driver for Davinci/Keystone archs.

v1..v2:

- added ti.cs-chipselect property instead to represent chipselect
number in cs node name.

Ivan Khoronzhuk (2):
  memory: ti-aemif: introduce AEMIF driver
  memory: ti-aemif: add bindings for AEMIF driver

 .../bindings/memory-controllers/ti-aemif.txt       |  201 ++++++++++
 drivers/memory/Kconfig                             |   11 +
 drivers/memory/Makefile                            |    1 +
 drivers/memory/ti-aemif.c                          |  415 ++++++++++++++++++++
 4 files changed, 628 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ti-aemif.txt
 create mode 100644 drivers/memory/ti-aemif.c

-- 
1.7.9.5
