From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed, 15 Mar 2017 23:51:37 +0800
Subject: [PATCH 1/4] dt-bindings: add vendor prefix for Shenzhen Nsiway
 Techonology Co., Ltd.
In-Reply-To: <20170315155140.54518-1-icenowy@aosc.xyz>
References: <20170315155140.54518-1-icenowy@aosc.xyz>
Message-ID: <20170315155140.54518-2-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shenzhen Nsiway Technology Co., Ltd. manufactures various analog ICs,
including pulse amplifiers, power management ICs and resistive
touchscreen controllers.

http://www.nsiway.com.cn

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 28c868638c6c..55ecac6737c3 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -215,6 +215,7 @@ newhaven	Newhaven Display International
 ni	National Instruments
 nintendo	Nintendo
 nokia	Nokia
+nsiway	Shenzhen Nsiway Technology Co., Ltd.
 nuvoton	Nuvoton Technology Corporation
 nvd	New Vision Display
 nvidia	NVIDIA
-- 
2.12.0
