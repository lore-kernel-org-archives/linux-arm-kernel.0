From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 15 Feb 2014 12:01:32 +0100
Subject: [PATCH v2 2/4] DT: Vender prefixes: Add ricoh, ssi and synology
In-Reply-To: <1392462094-25097-1-git-send-email-andrew@lunn.ch>
References: <1392462094-25097-1-git-send-email-andrew@lunn.ch>
Message-ID: <1392462094-25097-3-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following patches make use of vendor names ricoh, ssi and
synology.  Add them to the vendor prefix list.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Jason Cooper <jason@lakedaemon.net>
---
v2:
Use stock ticker for Ricoh as vendor name
s/Richoh/Ricoh/
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 3f900cd51bf0..9cef5cad9019 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -69,6 +69,7 @@ ralink	Mediatek/Ralink Technology Corp.
 ramtron	Ramtron International
 realtek Realtek Semiconductor Corp.
 renesas	Renesas Electronics Corporation
+ricoy	Ricoh Co. Ltd.
 rockchip	Fuzhou Rockchip Electronics Co., Ltd
 samsung	Samsung Semiconductor
 sbs	Smart Battery System
@@ -76,11 +77,13 @@ schindler	Schindler
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
1.8.5.3
