From: khuong.dinh@amperecomputing.com (Khuong Dinh)
Date: Fri, 20 Jul 2018 14:20:45 -0700
Subject: [PATCH] MAINTAINERS: Update Ampere email address
Message-ID: <1532121645-23575-1-git-send-email-khuong.dinh@amperecomputing.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates all APM email addresses to Ampere new email
addresses.

Signed-off-by: Khuong Dinh <khuong.dinh@amperecomputing.com>
---
 MAINTAINERS | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5917247..1f28433 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -979,26 +979,26 @@ F:        drivers/net/appletalk/
 F:     net/appletalk/

 APPLIED MICRO (APM) X-GENE DEVICE TREE SUPPORT
-M:     Duc Dang <dhdang@apm.com>
+M:     Khuong Dinh <khuong.dinh@amperecomputing.com>
 S:     Supported
 F:     arch/arm64/boot/dts/apm/

 APPLIED MICRO (APM) X-GENE SOC EDAC
-M:     Loc Ho <lho@apm.com>
+M:     Loc Ho <loc.ho@amperecomputing.com>
 S:     Supported
 F:     drivers/edac/xgene_edac.c
 F:     Documentation/devicetree/bindings/edac/apm-xgene-edac.txt

 APPLIED MICRO (APM) X-GENE SOC ETHERNET (V2) DRIVER
-M:     Iyappan Subramanian <isubramanian@apm.com>
-M:     Keyur Chudgar <kchudgar@apm.com>
+M:     Iyappan Subramanian <isubramanian@amperecomputing.com>
+M:     Keyur Chudgar <kchudgar@amperecomputing.com>
 S:     Supported
 F:     drivers/net/ethernet/apm/xgene-v2/

 APPLIED MICRO (APM) X-GENE SOC ETHERNET DRIVER
-M:     Iyappan Subramanian <isubramanian@apm.com>
-M:     Keyur Chudgar <kchudgar@apm.com>
-M:     Quan Nguyen <qnguyen@apm.com>
+M:     Iyappan Subramanian <isubramanian@amperecomputing.com>
+M:     Keyur Chudgar <kchudgar@amperecomputing.com>
+M:     Quan Nguyen <qnguyen@amperecomputing.com>
 S:     Supported
 F:     drivers/net/ethernet/apm/xgene/
 F:     drivers/net/phy/mdio-xgene.c
@@ -1006,7 +1006,7 @@ F:        Documentation/devicetree/bindings/net/apm-xgene-enet.txt
 F:     Documentation/devicetree/bindings/net/apm-xgene-mdio.txt

 APPLIED MICRO (APM) X-GENE SOC PMU
-M:     Tai Nguyen <ttnguyen@apm.com>
+M:     Hoan Tran <hoan.tran@amperecomputing.com>
 S:     Supported
 F:     drivers/perf/xgene_pmu.c
 F:     Documentation/perf/xgene-pmu.txt
@@ -10944,7 +10944,7 @@ F:      Documentation/devicetree/bindings/pci/altera-pcie.txt
 F:     drivers/pci/controller/pcie-altera.c

 PCI DRIVER FOR APPLIEDMICRO XGENE
-M:     Tanmay Inamdar <tinamdar@apm.com>
+M:     Toan Le <toanle@amperecomputing.com>
 L:     linux-pci at vger.kernel.org
 L:     linux-arm-kernel at lists.infradead.org
 S:     Maintained
@@ -11109,7 +11109,7 @@ F:      Documentation/devicetree/bindings/pci/altera-pcie-msi.txt
 F:     drivers/pci/controller/pcie-altera-msi.c

 PCI MSI DRIVER FOR APPLIEDMICRO XGENE
-M:     Duc Dang <dhdang@apm.com>
+M:     Khuong Dinh <khuong.dinh@amperecomputing.com>
 L:     linux-pci at vger.kernel.org
 L:     linux-arm-kernel at lists.infradead.org
 S:     Maintained
@@ -13869,7 +13869,7 @@ S:      Maintained
 F:     drivers/tty/serial/8250/8250_dw.c

 SYNOPSYS DESIGNWARE APB GPIO DRIVER
-M:     Hoan Tran <hotran@apm.com>
+M:     Hoan Tran <hoan.tran@amperecomputing.com>
 L:     linux-gpio at vger.kernel.org
 S:     Maintained
 F:     drivers/gpio/gpio-dwapb.c
--
1.8.3.1

CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is for the sole use of the intended recipient(s) and contains information that is confidential and proprietary to Ampere Computing or its subsidiaries. It is to be used solely for the purpose of furthering the parties' business relationship. Any review, copying, or distribution of this email (or any attachments thereto) is strictly prohibited. If you are not the intended recipient, please contact the sender immediately and permanently delete the original and any copies of this email and any attachments thereto.
