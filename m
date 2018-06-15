From: ben.whitten@gmail.com (Ben Whitten)
Date: Fri, 15 Jun 2018 14:40:50 +0100
Subject: [PATCH v2 1/6] dt-bindings: add laird and giantec vendor prefix
Message-ID: <1529070055-18701-1-git-send-email-ben.whitten@lairdtech.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a vendor prefix "laird" for Laird PLC who make
CPU modules and system on chips.
Also adds "giantec" for Giantec Semiconductor, Inc. who
make eeprom memory used on Laird designs.

Signed-off-by: Ben Whitten <ben.whitten@lairdtech.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a38d8bf..adf808c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -132,6 +132,7 @@ geekbuying	GeekBuying
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 GEFanuc	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
 geniatech	Geniatech, Inc.
+giantec	Giantec Semiconductor, Inc.
 giantplus	Giantplus Technology Co., Ltd.
 globalscale	Globalscale Technologies, Inc.
 gmt	Global Mixed-mode Technology, Inc.
@@ -188,6 +189,7 @@ kingnovel	Kingnovel Technology Co., Ltd.
 kosagi	Sutajio Ko-Usagi PTE Ltd.
 kyo	Kyocera Corporation
 lacie	LaCie
+laird	Laird PLC
 lantiq	Lantiq Semiconductor
 lattice	Lattice Semiconductor
 lego	LEGO Systems A/S
-- 
2.7.4
