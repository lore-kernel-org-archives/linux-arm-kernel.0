From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 25 Feb 2014 20:05:41 +0100
Subject: =?UTF-8?q?=5BPATCH=201/2=5D=20of=3A=20Add=20vendor=20prefixes=20used=20by=20Kirkwood=20devices?=
Message-ID: <1393355142-7811-1-git-send-email-andrew@lunn.ch>
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
@@ -18,6 +18,7 @@ auo	AU Optronics Corporation
 avago	Avago Technologies
 bosch	Bosch Sensortec GmbH
 brcm	Broadcom Corporation
+buffalo	Buffalo, Inc.
 capella	Capella Microsystems, Inc
 cavium	Cavium, Inc.
 cdns	Cadence Design Systems Inc.
@@ -28,25 +29,31 @@ cortina	Cortina Systems, Inc.
 dallas	Maxim Integrated Products (formerly Dallas Semiconductor)
 davicom	DAVICOM Semiconductor, Inc.
 denx	Denx Software Engineering
+dlink	D-Link Corporation
 edt	Emerging Display Technologies
 emmicro	EM Microelectronic
 epfl	Ecole Polytechnique F?d?rale de Lausanne
 epson	Seiko Epson Corp.
 est	ESTeem Wireless Modems
+excito	Excito
 fsl	Freescale Semiconductor
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gmt	Global Mixed-mode Technology, Inc.
+globalscale	GlobalScale Technologies, Inc.
 gumstix	Gumstix, Inc.
 haoyu	Haoyu Microelectronic Co. Ltd.
 hisilicon	Hisilicon Limited.
 hp	Hewlett Packard
 ibm	International Business Machines (IBM)
 idt	Integrated Device Technologies, Inc.
+iom	Iomega Corporation
 img	Imagination Technologies Ltd.
 intercontrol	Inter Control Group
 isl	Intersil
 karo	Ka-Ro electronics GmbH
+keymile	Keymile GmbH
+lacie	LaCie
 lg	LG Corporation
 linux	Linux-specific binding
 lsi	LSI Corp. (LSI Logic)
@@ -54,7 +61,9 @@ marvell	Marvell Technology Group Ltd.
 maxim	Maxim Integrated Products
 microchip	Microchip Technology Inc.
 mosaixtech	Mosaix Technologies, Inc.
+mpl	MPL AG
 national	National Semiconductor
+netgear	Netgear, Inc.
 nintendo	Nintendo
 nvidia	NVIDIA
 nxp	NXP Semiconductors
@@ -62,10 +71,12 @@ onnn	ON Semiconductor Corp.
 panasonic	Panasonic Corporation
 phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
+plathome	Plat'Home Co., Ltd.
 powervr	PowerVR (deprecated, use img)
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm, Inc.
 qnap	QNAP Systems, Inc.
+raidsonic	RaidSonic Technology GmbH
 ralink	Mediatek/Ralink Technology Corp.
 ramtron	Ramtron International
 realtek Realtek Semiconductor Corp.
@@ -75,6 +86,7 @@ rockchip	Fuzhou Rockchip Electronics Co., Ltd
 samsung	Samsung Semiconductor
 sbs	Smart Battery System
 schindler	Schindler
+seagate	Seagate Technology PLC
 sil	Silicon Image
 silabs	Silicon Laboratories
 simtek
@@ -95,3 +107,4 @@ winbond Winbond Electronics corp.
 wlf	Wolfson Microelectronics
 wm	Wondermedia Technologies, Inc.
 xlnx	Xilinx
+zyxel	ZyXEL Communications Corp.
-- 
1.8.5.3
