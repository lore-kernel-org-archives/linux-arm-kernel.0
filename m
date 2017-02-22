From: steven.lin1@broadcom.com (Steve Lin)
Date: Wed, 22 Feb 2017 15:42:24 -0500
Subject: [PATCH 0/2] Add Northstar plus suport to PDC mailbox driver
Message-ID: <1487796146-14690-1-git-send-email-steven.lin1@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds support for Broadcom Northstar+ to mailbox (PDC) driver.

Patch 1/2: Driver code and Kconfig changes
Patch 2/2: Device tree and documentation changes

Steve Lin (2):
  mailbox: bcm-pdc: Add Northstar Plus support to PDC driver
  ARM: dts: NSP: Add mailbox (PDC) to NSP

 .../bindings/mailbox/brcm,iproc-pdc-mbox.txt       |  6 ++-
 arch/arm/boot/dts/bcm-nsp.dtsi                     |  9 ++++
 drivers/mailbox/Kconfig                            |  9 ++--
 drivers/mailbox/bcm-pdc-mailbox.c                  | 61 ++++++++++++++++------
 4 files changed, 63 insertions(+), 22 deletions(-)

-- 
2.1.0
