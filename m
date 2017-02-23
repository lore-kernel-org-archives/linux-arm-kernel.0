From: steven.lin1@broadcom.com (Steve Lin)
Date: Thu, 23 Feb 2017 09:49:49 -0500
Subject: [PATCH v2 0/3] Add Northstar Plus support to PDC mailbox driver
Message-ID: <1487861392-23039-1-git-send-email-steven.lin1@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support for Broadcom Northstar+ to mailbox (PDC) driver.

Patch 1/3: Driver code and Kconfig changes
Patch 2/3: Device tree changes
Patch 3/3: DT bindings documentation changes

v2 addresses Jon Mason's suggestion about making the bindings doc change
a separate patch.

Steve Lin (3):
  mailbox: bcm-pdc: Add Northstar Plus support to PDC driver
  ARM: dts: NSP: Add mailbox (PDC) to NSP
  dt-bindings: mailbox: Update doc with NSP PDC/mailbox support

 .../bindings/mailbox/brcm,iproc-pdc-mbox.txt       |  6 ++-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  9 ++++
 drivers/mailbox/Kconfig                            |  9 ++--
 drivers/mailbox/bcm-pdc-mailbox.c                  | 61 ++++++++++++++++------
 4 files changed, 63 insertions(+), 22 deletions(-)

-- 
2.1.0
