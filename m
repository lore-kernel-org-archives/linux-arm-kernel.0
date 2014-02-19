From: klightspeed@killerwolves.net (klightspeed at killerwolves.net)
Date: Thu, 20 Feb 2014 06:02:34 +1000
Subject: [PATCH v7 1/4] DT: Vendor prefixes: Add ricoh, qnap, sii and synology
In-Reply-To: <1392840157-31072-1-git-send-email-klightspeed@killerwolves.net>
References: <1392840157-31072-1-git-send-email-klightspeed@killerwolves.net>
Message-ID: <1392840157-31072-2-git-send-email-klightspeed@killerwolves.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>

The following patches make use of vendor names:
* ricoh (Ricoh Co. Ltd.);
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

v7:
Revert ricoh vendor prefix change from v2

---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 3f900cd..4a52fa9 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -65,10 +65,12 @@ picochip	Picochip Ltd
 powervr	PowerVR (deprecated, use img)
 qca	Qualcomm Atheros, Inc.
 qcom	Qualcomm, Inc.
+qnap	QNAP Systems, Inc.
 ralink	Mediatek/Ralink Technology Corp.
 ramtron	Ramtron International
 realtek Realtek Semiconductor Corp.
 renesas	Renesas Electronics Corporation
+ricoh	Ricoh Co. Ltd.
 rockchip	Fuzhou Rockchip Electronics Co., Ltd
 samsung	Samsung Semiconductor
 sbs	Smart Battery System
@@ -76,11 +78,13 @@ schindler	Schindler
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
