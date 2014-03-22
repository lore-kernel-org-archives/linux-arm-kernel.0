From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 22 Mar 2014 13:45:56 +0100
Subject: =?UTF-8?q?=5BPATCH=201/5=5D=20DT=3A=20Vendor=3A=20Add=20prefixes=20used=20by=20Kirkwood=20devices?=
In-Reply-To: <1395492360-1865-1-git-send-email-andrew@lunn.ch>
References: <1395492360-1865-1-git-send-email-andrew@lunn.ch>
Message-ID: <1395492360-1865-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a number of vendor prefixes by kirkwood devices. These are not all
stock tickers, but have been in use for a while so changing would not
be easy.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 0f01c9bf19c8..838e8bbbabca 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -24,2 +24,3 @@ bosch	Bosch Sensortec GmbH
 brcm	Broadcom Corporation
+buffalo	Buffalo, Inc.
 calxeda	Calxeda
@@ -35,4 +36,4 @@ dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
 davicom	DAVICOM Semiconductor, Inc.
-dlink	D-Link Systems, Inc.
 denx	Denx Software Engineering
+dlink	D-Link Corporation
 dmo	Data Modul AG
@@ -44,2 +45,3 @@ est	ESTeem Wireless Modems
 eukrea  Eukr?a Electromatique
+excito	Excito
 fsl	Freescale Semiconductor
@@ -57,2 +59,3 @@ ibm	International Business Machines (IBM)
 idt	Integrated Device Technologies, Inc.
+iom	Iomega Corporation
 img	Imagination Technologies Ltd.
@@ -62,2 +65,3 @@ isl	Intersil
 karo	Ka-Ro electronics GmbH
+keymile	Keymile GmbH
 lacie	LaCie
@@ -72,2 +76,4 @@ mosaixtech	Mosaix Technologies, Inc.
 moxa	Moxa
+mpl	MPL AG
+mxicy	Macronix International Co., Ltd.
 national	National Semiconductor
@@ -84,2 +90,3 @@ phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
+plathome	Plat'Home Co., Ltd.
 powervr	PowerVR (deprecated, use img)
@@ -88,2 +95,3 @@ qcom	Qualcomm Technologies, Inc
 qnap	QNAP Systems, Inc.
+raidsonic	RaidSonic Technology GmbH
 ralink	Mediatek/Ralink Technology Corp.
@@ -97,2 +105,3 @@ sbs	Smart Battery System
 schindler	Schindler
+seagate	Seagate Technology PLC
 sil	Silicon Image
@@ -113,2 +122,3 @@ toshiba	Toshiba Corporation
 toumaz	Toumaz
+usi	Universal Scientifc Industrial Co., Ltd.
 v3	V3 Semiconductor
@@ -121 +131,2 @@ xes	Extreme Engineering Solutions (X-ES)
 xlnx	Xilinx
+zyxel	ZyXEL Communications Corp.
-- 
1.9.1
