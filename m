From: andrea.gelmini@gelma.net (Andrea Gelmini)
Date: Sun, 23 May 2010 21:55:44 +0200
Subject: [PATCH 135/199] arch/arm/mach-footbridge/ebsa285-pci.c: Checkpatch
	cleanup
In-Reply-To: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
References: <1274644549-24952-1-git-send-email-andrea.gelmini@gelma.net>
Message-ID: <1274644549-24952-8-git-send-email-andrea.gelmini@gelma.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/mach-footbridge/ebsa285-pci.c:22: ERROR: switch and case should be at the same indent

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/arm/mach-footbridge/ebsa285-pci.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-footbridge/ebsa285-pci.c b/arch/arm/mach-footbridge/ebsa285-pci.c
index 720c0ba..e5ab5bd 100644
--- a/arch/arm/mach-footbridge/ebsa285-pci.c
+++ b/arch/arm/mach-footbridge/ebsa285-pci.c
@@ -20,9 +20,9 @@ static int __init ebsa285_map_irq(struct pci_dev *dev, u8 slot, u8 pin)
 	if (dev->vendor == PCI_VENDOR_ID_CONTAQ &&
 	    dev->device == PCI_DEVICE_ID_CONTAQ_82C693)
 		switch (PCI_FUNC(dev->devfn)) {
-			case 1:	return 14;
-			case 2:	return 15;
-			case 3:	return 12;
+		case 1:	return 14;
+		case 2:	return 15;
+		case 3:	return 12;
 		}
 
 	return irqmap_ebsa285[(slot + pin) & 3];
-- 
1.7.1.251.gf80a2
