From: rric@kernel.org (Robert Richter)
Date: Fri,  5 Jun 2015 19:49:24 +0200
Subject: [PATCH v5 0/2] ahci: Add generic MSI-X support for single interrupts
 to SATA PCI
Message-ID: <1433526566-21136-1-git-send-email-rric@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Richter <rrichter@cavium.com>

This patch set adds generic support for MSI-X interrupts to the SATA
PCI driver.

One patch does the generic change, the other add support for Cavium's
ThunderX host controller.


Robert Richter (2):
  ahci: Add generic MSI-X support for single interrupts to SATA PCI
    driver
  ahci: Add support for Cavium's ThunderX host controller

 drivers/ata/ahci.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

-- 
2.1.1
