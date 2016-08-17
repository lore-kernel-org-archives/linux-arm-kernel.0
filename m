From: ccc94453@vip.cybercity.dk (Rask Ingemann Lambertsen)
Date: Wed, 17 Aug 2016 23:13:34 +0200
Subject: [PATCH v3 1/3] devicetree: Sort vendor prefixes in alphabetical order
Message-ID: <54da74da3f60ede0bf8fb789ffee584703e81a29.1471553094.git.ccc94453@vip.cybercity.dk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vendor prefixes should be listed in alphabetical order, which some of
them weren't, so this patch corrects that.

Signed-off-by: Rask Ingemann Lambertsen <ccc94453@vip.cybercity.dk>
---

I used 'sort --ignore-case --key 1,1'.

Changes in v3:
This patch is new in v3.

 .../devicetree/bindings/vendor-prefixes.txt        | 30 +++++++++++-----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 1992aa9..69398cf 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -3,8 +3,8 @@ Device tree binding vendor prefix registry.  Keep list in alphabetical order.
 This isn't an exhaustive list, but you should add new prefixes to it before
 using them to avoid name-space collisions.
 
-abilis	Abilis Systems
 abcn	Abracon Corporation
+abilis	Abilis Systems
 active-semi	Active-Semi International Inc
 ad	Avionic Design GmbH
 adapteva	Adapteva, Inc.
@@ -54,8 +54,8 @@ chipone		ChipOne
 chipspark	ChipSPARK
 chrp	Common Hardware Reference Platform
 chunghwa	Chunghwa Picture Tubes Ltd.
-ciaa	Computadora Industrial Abierta Argentina
 cirrus	Cirrus Logic, Inc.
+ciaa	Computadora Industrial Abierta Argentina
 cloudengines	Cloud Engines, Inc.
 cnm	Chips&Media, Inc.
 cnxt	Conexant Systems, Inc.
@@ -101,8 +101,8 @@ focaltech	FocalTech Systems Co.,Ltd
 fsl	Freescale Semiconductor
 ge	General Electric Company
 geekbuying	GeekBuying
-GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
+GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 geniatech	Geniatech, Inc.
 giantplus	Giantplus Technology Co., Ltd.
 globalscale	Globalscale Technologies, Inc.
@@ -126,7 +126,6 @@ i2se	I2SE GmbH
 ibm	International Business Machines (IBM)
 idt	Integrated Device Technologies, Inc.
 ifi	Ingenieurburo Fur Ic-Technologie (I/F/I)
-iom	Iomega Corporation
 img	Imagination Technologies Ltd.
 infineon Infineon Technologies
 inforce	Inforce Computing
@@ -135,6 +134,7 @@ innolux	Innolux Corporation
 intel	Intel Corporation
 intercontrol	Inter Control Group
 invensense	InvenSense Inc.
+iom	Iomega Corporation
 isee	ISEE 2007 S.L.
 isil	Intersil
 issi	Integrated Silicon Solutions Inc.
@@ -149,8 +149,8 @@ lantiq	Lantiq Semiconductor
 lenovo	Lenovo Group Ltd.
 lg	LG Corporation
 linux	Linux-specific binding
-lsi	LSI Corp. (LSI Logic)
 lltc	Linear Technology Corporation
+lsi	LSI Corp. (LSI Logic)
 marvell	Marvell Technology Group Ltd.
 maxim	Maxim Integrated Products
 meas	Measurement Specialties
@@ -190,20 +190,20 @@ onnn	ON Semiconductor Corp.
 ontat	On Tat Industrial Company
 opencores	OpenCores.org
 option	Option NV
+ORCL	Oracle Corporation
 ortustech	Ortus Technology Co., Ltd.
 ovti	OmniVision Technologies
-ORCL	Oracle Corporation
 oxsemi	Oxford Semiconductor, Ltd.
 panasonic	Panasonic Corporation
 parade	Parade Technologies Inc.
 pericom	Pericom Technology Inc.
 phytec	PHYTEC Messtechnik GmbH
 picochip	Picochip Ltd
+pixcir  PIXCIR MICROELECTRONICS Co., Ltd
 plathome	Plat'Home Co., Ltd.
 plda	PLDA
-pixcir  PIXCIR MICROELECTRONICS Co., Ltd
-pulsedlight	PulsedLight, Inc
 powervr	PowerVR (deprecated, use img)
+pulsedlight	PulsedLight, Inc
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
 qemu	QEMU, a generic and open source machine emulator and virtualizer
@@ -231,12 +231,12 @@ sgx	SGX Sensortech
 sharp	Sharp Corporation
 si-en	Si-En Technology Ltd.
 sigma	Sigma Designs, Inc.
+sii	Seiko Instruments, Inc.
 sil	Silicon Image
 silabs	Silicon Laboratories
+silergy	Silergy Corp.
 siliconmitus	Silicon Mitus, Inc.
 simtek
-sii	Seiko Instruments, Inc.
-silergy	Silergy Corp.
 sirf	SiRF Technology, Inc.
 sis	Silicon Integrated Systems Corp.
 sitronix	Sitronix Technology Corporation
@@ -254,9 +254,9 @@ starry	Starry Electronic Technology (ShenZhen) Co., LTD
 startek	Startek
 ste	ST-Ericsson
 stericsson	ST-Ericsson
+SUNW	Sun Microsystems, Inc
 syna	Synaptics Inc.
 synology	Synology, Inc.
-SUNW	Sun Microsystems, Inc
 tbs	TBS Technologies
 tcg	Trusted Computing Group
 tcl	Toby Churchill Ltd.
@@ -268,14 +268,14 @@ tlm	Trusted Logic Mobility
 toradex	Toradex AG
 toshiba	Toshiba Corporation
 toumaz	Toumaz
-tplink	TP-LINK Technologies Co., Ltd.
 tpk	TPK U.S.A. LLC
+tplink	TP-LINK Technologies Co., Ltd.
 tronfy	Tronfy
 tronsmart	Tronsmart
 truly	Truly Semiconductors Limited
 tyan	Tyan Computer Corporation
-upisemi	uPI Semiconductor Corp.
 uniwest	United Western Technologies Corp (UniWest)
+upisemi	uPI Semiconductor Corp.
 urt	United Radiant Technology Corporation
 usi	Universal Scientific Industrial Co., Ltd.
 v3	V3 Semiconductor
@@ -289,11 +289,11 @@ wexler	Wexler
 winbond Winbond Electronics corp.
 wlf	Wolfson Microelectronics
 wm	Wondermedia Technologies, Inc.
-x-powers	X-Powers
 xes	Extreme Engineering Solutions (X-ES)
 xillybus	Xillybus Ltd.
 xlnx	Xilinx
-zyxel	ZyXEL Communications Corp.
+x-powers	X-Powers
 zarlink	Zarlink Semiconductor
 zii	Zodiac Inflight Innovations
 zte	ZTE Corp.
+zyxel	ZyXEL Communications Corp.
-- 
2.8.1
