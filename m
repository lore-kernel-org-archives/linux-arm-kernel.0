From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Tue, 01 Mar 2016 08:49:10 +0100
Subject: [PATCH] CNS3xxx: remove unused *_VIRT definitions
In-Reply-To: <m3y4a2od0j.fsf@t19.piap.pl> ("Krzysztof
 \=\?utf-8\?Q\?Ha\=C5\=82as\?\=
 \=\?utf-8\?Q\?a\=22's\?\= message of
 "Tue, 01 Mar 2016 08:47:40 +0100")
References: <m3y4a2od0j.fsf@t19.piap.pl>
Message-ID: <m3twkqocy1.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Krzysztof Ha?asa <khalasa@piap.pl>

diff --git a/arch/arm/mach-cns3xxx/cns3xxx.h b/arch/arm/mach-cns3xxx/cns3xxx.h
index a0f5b60..a642ba5 100644
--- a/arch/arm/mach-cns3xxx/cns3xxx.h
+++ b/arch/arm/mach-cns3xxx/cns3xxx.h
@@ -162,13 +162,11 @@
 #define CNS3XXX_L2C_BASE			0x92000000	/* L2 Cache Control */
 
 #define CNS3XXX_PCIE0_MEM_BASE			0xA0000000	/* PCIe Port 0 IO/Memory Space */
-#define CNS3XXX_PCIE0_MEM_BASE_VIRT		0xE0000000
 
 #define CNS3XXX_PCIE0_HOST_BASE			0xAB000000	/* PCIe Port 0 RC Base */
 #define CNS3XXX_PCIE0_HOST_BASE_VIRT		0xE1000000
 
 #define CNS3XXX_PCIE0_IO_BASE			0xAC000000	/* PCIe Port 0 */
-#define CNS3XXX_PCIE0_IO_BASE_VIRT		0xE2000000
 
 #define CNS3XXX_PCIE0_CFG0_BASE			0xAD000000	/* PCIe Port 0 CFG Type 0 */
 #define CNS3XXX_PCIE0_CFG0_BASE_VIRT		0xE3000000
@@ -177,16 +175,13 @@
 #define CNS3XXX_PCIE0_CFG1_BASE_VIRT		0xE4000000
 
 #define CNS3XXX_PCIE0_MSG_BASE			0xAF000000	/* PCIe Port 0 Message Space */
-#define CNS3XXX_PCIE0_MSG_BASE_VIRT		0xE5000000
 
 #define CNS3XXX_PCIE1_MEM_BASE			0xB0000000	/* PCIe Port 1 IO/Memory Space */
-#define CNS3XXX_PCIE1_MEM_BASE_VIRT		0xE8000000
 
 #define CNS3XXX_PCIE1_HOST_BASE			0xBB000000	/* PCIe Port 1 RC Base */
 #define CNS3XXX_PCIE1_HOST_BASE_VIRT		0xE9000000
 
 #define CNS3XXX_PCIE1_IO_BASE			0xBC000000	/* PCIe Port 1 */
-#define CNS3XXX_PCIE1_IO_BASE_VIRT		0xEA000000
 
 #define CNS3XXX_PCIE1_CFG0_BASE			0xBD000000	/* PCIe Port 1 CFG Type 0 */
 #define CNS3XXX_PCIE1_CFG0_BASE_VIRT		0xEB000000
@@ -195,7 +190,6 @@
 #define CNS3XXX_PCIE1_CFG1_BASE_VIRT		0xEC000000
 
 #define CNS3XXX_PCIE1_MSG_BASE			0xBF000000	/* PCIe Port 1 Message Space */
-#define CNS3XXX_PCIE1_MSG_BASE_VIRT		0xED000000
 
 /*
  * Testchip peripheral and fpga gic regions

-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
