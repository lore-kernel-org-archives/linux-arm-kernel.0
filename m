From: klightspeed@killerwolves.net (klightspeed at killerwolves.net)
Date: Thu, 20 Feb 2014 04:59:11 +1000
Subject: [PATCH v6 1/4] DT: Vendor prefixes: Add ricoh, qnap, sii and synology
In-Reply-To: <1392836354-28886-1-git-send-email-klightspeed@killerwolves.net>
References: <1392836354-28886-1-git-send-email-klightspeed@killerwolves.net>
Message-ID: <1392836354-28886-2-git-send-email-klightspeed@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

The following patches make use of vendor names:
* ricoy (Ricoh Co. Ltd.);
* qnap (QNAP Systems, Inc.);
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

v6:
Revert qnap vendor prefix change from v5
Now properly based on -rc1

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
 qcom	Qualcomm, Inc
+qnap	QNAP Systems, Inc.
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
 st	STMicroelectronics
 ste	ST-Ericsson
 stericsson	ST-Ericsson
+synology	Synology, Inc.
 ti	Texas Instruments
 tlm	Trusted Logic Mobility
 toshiba	Toshiba Corporation
-- 
1.8.3.2
