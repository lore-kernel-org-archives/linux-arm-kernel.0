From: andrew@lunn.ch (Andrew Lunn)
Date: Wed,  5 Mar 2014 22:21:13 +0100
Subject: [RESEND Patch 1/2] DT: Vendor: Add prefixes used by Kirkwood devices
In-Reply-To: <1394054474-4310-1-git-send-email-andrew@lunn.ch>
References: <1394054474-4310-1-git-send-email-andrew@lunn.ch>
Message-ID: <1394054474-4310-2-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a number of vendor prefixes by kirkwood devices. These are not all
stock tickers, but have been in use for a while so changing would not
be easy.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index c73b435f58f5..860c467374fe 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -20,2 +20,3 @@ bosch	Bosch Sensortec GmbH
 brcm	Broadcom Corporation
+buffalo	Buffalo, Inc.
 capella	Capella Microsystems, Inc
@@ -30,2 +31,3 @@ davicom	DAVICOM Semiconductor, Inc.
 denx	Denx Software Engineering
+dlink	D-Link Corporation
 edt	Emerging Display Technologies
@@ -35,2 +37,3 @@ epson	Seiko Epson Corp.
 est	ESTeem Wireless Modems
+excito	Excito
 fsl	Freescale Semiconductor
@@ -39,2 +42,3 @@ gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gmt	Global Mixed-mode Technology, Inc.
+globalscale	GlobalScale Technologies, Inc.
 gumstix	Gumstix, Inc.
@@ -45,2 +49,3 @@ ibm	International Business Machines (IBM)
 idt	Integrated Device Technologies, Inc.
+iom	Iomega Corporation
 img	Imagination Technologies Ltd.
@@ -49,2 +54,4 @@ isl	Intersil
 karo	Ka-Ro electronics GmbH
+keymile	Keymile GmbH
+lacie	LaCie
 lg	LG Corporation
@@ -56,3 +63,5 @@ microchip	Microchip Technology Inc.
 mosaixtech	Mosaix Technologies, Inc.
+mpl	MPL AG
 national	National Semiconductor
+netgear	Netgear, Inc.
 nintendo	Nintendo
@@ -64,2 +73,3 @@ phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
+plathome	Plat'Home Co., Ltd.
 powervr	PowerVR (deprecated, use img)
@@ -68,2 +78,3 @@ qcom	Qualcomm, Inc.
 qnap	QNAP Systems, Inc.
+raidsonic	RaidSonic Technology GmbH
 ralink	Mediatek/Ralink Technology Corp.
@@ -77,2 +88,3 @@ sbs	Smart Battery System
 schindler	Schindler
+seagate	Seagate Technology PLC
 sil	Silicon Image
@@ -97 +109,2 @@ wm	Wondermedia Technologies, Inc.
 xlnx	Xilinx
+zyxel	ZyXEL Communications Corp.
-- 
1.9.0
