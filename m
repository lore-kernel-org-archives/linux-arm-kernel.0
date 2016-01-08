From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 8 Jan 2016 10:13:43 +0800
Subject: [PATCH 0/2] power: act8945a: add charger driver for the sub-device of
 ACT8945A MFD
Message-ID: <1452219225-10510-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACT8945A is a Multi Function Device with the following subdevices:
 - Regulator
 - Charger

This patch set is to add regulator driver for ACT8945A.
It is based on the patch set:
	[PATCH] mfd: act8945a: add Active-semi ACT8945A PMIC MFD driver


Wenyou Yang (2):
  power: act8945a: add charger driver for ACT8945A
  power: add documentation for ACT8945A's charger DT bindings

 .../devicetree/bindings/power/act8945a-charger.txt |   34 ++
 drivers/power/Kconfig                              |    7 +
 drivers/power/Makefile                             |    1 +
 drivers/power/act8945a_charger.c                   |  397 ++++++++++++++++++++
 4 files changed, 439 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/act8945a-charger.txt
 create mode 100644 drivers/power/act8945a_charger.c

-- 
1.7.9.5
