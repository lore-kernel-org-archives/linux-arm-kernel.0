From: sebastien.bourdelin@savoirfairelinux.com (Sebastien Bourdelin)
Date: Thu,  2 Nov 2017 14:17:11 -0400
Subject: [PATCH v7 0/2] add support for the Technologic Systems NBUS
Message-ID: <20171102181713.8076-1-sebastien.bourdelin@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I reposts these patches to the ARM mailing list following the suggestion
from Linus Walleij [1] to ask if you can apply them directly for the
upstream kernel.

Best Regards,
Sebastien Bourdelin.

 [1] https://lkml.org/lkml/2017/11/2/629

Sebastien Bourdelin (2):
  dt-bindings: bus: Add documentation for the Technologic Systems NBUS
  bus: add driver for the Technologic Systems NBUS

 Documentation/devicetree/bindings/bus/ts-nbus.txt |  50 +++
 drivers/bus/Kconfig                               |   8 +
 drivers/bus/Makefile                              |   1 +
 drivers/bus/ts-nbus.c                             | 375 ++++++++++++++++++++++
 include/linux/ts-nbus.h                           |  18 ++
 5 files changed, 452 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/ts-nbus.txt
 create mode 100644 drivers/bus/ts-nbus.c
 create mode 100644 include/linux/ts-nbus.h

-- 
2.15.0
