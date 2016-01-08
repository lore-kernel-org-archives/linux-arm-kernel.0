From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Fri, 8 Jan 2016 10:08:56 +0800
Subject: [PATCH 0/2] regulator: act8945a: add regulator driver for the
 sub-device of ACT8945A MFD
Message-ID: <1452218938-10621-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACT8945A is a Multi Function Device with the following subdevices:
 - Regulator
 - Charger

This patch set is to add regulator driver for ACT8945A.
It is based on the patch set:
	[PATCH] mfd: act8945a: add Active-semi ACT8945A PMIC MFD driver


Wenyou Yang (2):
  regulator: act8945a: add regulator driver for ACT8945A
  regulator: add documentation for ACT8945A's regulator DT bindings

 .../bindings/regulator/act8945a-regulator.txt      |   78 +++++
 drivers/regulator/Kconfig                          |    7 +
 drivers/regulator/Makefile                         |    1 +
 drivers/regulator/act8945a-regulator.c             |  299 ++++++++++++++++++++
 4 files changed, 385 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/regulator/act8945a-regulator.txt
 create mode 100644 drivers/regulator/act8945a-regulator.c

-- 
1.7.9.5
