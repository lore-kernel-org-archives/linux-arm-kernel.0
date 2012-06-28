From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 28 Jun 2012 15:53:46 +0200
Subject: [PATCH v2 1/4] usb: chipidea: pci: make platformdata static
In-Reply-To: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
References: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1340891629-13145-2-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/usb/chipidea/ci13xxx_pci.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/chipidea/ci13xxx_pci.c b/drivers/usb/chipidea/ci13xxx_pci.c
index 918e149..9f5c171 100644
--- a/drivers/usb/chipidea/ci13xxx_pci.c
+++ b/drivers/usb/chipidea/ci13xxx_pci.c
@@ -23,17 +23,17 @@
 /******************************************************************************
  * PCI block
  *****************************************************************************/
-struct ci13xxx_platform_data pci_platdata = {
+static struct ci13xxx_platform_data pci_platdata = {
 	.name		= UDC_DRIVER_NAME,
 	.capoffset	= DEF_CAPOFFSET,
 };
 
-struct ci13xxx_platform_data langwell_pci_platdata = {
+static struct ci13xxx_platform_data langwell_pci_platdata = {
 	.name		= UDC_DRIVER_NAME,
 	.capoffset	= 0,
 };
 
-struct ci13xxx_platform_data penwell_pci_platdata = {
+static struct ci13xxx_platform_data penwell_pci_platdata = {
 	.name		= UDC_DRIVER_NAME,
 	.capoffset	= 0,
 	.power_budget	= 200,
-- 
1.7.10
