From: klightspeed@killerwolves.net (klightspeed at killerwolves.net)
Date: Wed, 19 Feb 2014 22:49:10 +1000
Subject: [PATCH v5 1/5] DT: Vendor prefixes: Add ricoh, qnap, sii and synology
In-Reply-To: <1392814154-11284-1-git-send-email-klightspeed@killerwolves.net>
References: <1392814154-11284-1-git-send-email-klightspeed@killerwolves.net>
Message-ID: <1392814154-11284-2-git-send-email-klightspeed@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

The following patches make use of vendor names:
* ricoy (Ricoh Co. Ltd.);
* qnapsz (QNAP Systems, Inc.);
* sii (Seiko Instruments, Inc.); and
* synology (Synology, Inc.)

Add them to the vendor prefix list.

Signed-off-by: Ben Peddell <klightspeed@killerwolves.net>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
v2:
Use stock ticker for Ricoh as vendor name
s/Richoh/Ricoh/

v5:
Add vendor prefix for QNAP
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 40ce2df..ef1b77c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -68,10 +68,12 @@ picochip	Picochip Ltd
 powervr	PowerVR (deprecated, use img)
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm Technologies, Inc
+qnapsz	QNAP Systems, Inc.
 ralink	Mediatek/Ralink Technology Corp.
 ramtron	Ramtron International
 realtek Realtek Semiconductor Corp.
 renesas	Renesas Electronics Corporation
+ricoy	Ricoh Co. Ltd.
 rockchip	Fuzhou Rockchip Electronics Co., Ltd
 samsung	Samsung Semiconductor
 sbs	Smart Battery System
@@ -79,12 +81,14 @@ schindler	Schindler
 sil	Silicon Image
 silabs	Silicon Laboratories
 simtek
+sii	Seiko Instruments, Inc.
 sirf	SiRF Technology, Inc.
 snps 	Synopsys, Inc.
 spansion	Spansion Inc.
 st	STMicroelectronics
 ste	ST-Ericsson
 stericsson	ST-Ericsson
+synology	Synology, Inc.
 ti	Texas Instruments
 tlm	Trusted Logic Mobility
 toshiba	Toshiba Corporation
-- 
1.8.3.2
