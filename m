From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 14 Jan 2016 16:25:07 +0100
Subject: [PATCH v2 24/26] devicetree: Add olimex vendor prefix
In-Reply-To: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1452785109-6172-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1452785109-6172-25-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olimex is an open source hardware boards vendors based in Bulgaria.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 55df1d444e9f..de4eb72b3adc 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -161,6 +161,7 @@ nuvoton	Nuvoton Technology Corporation
 nvidia	NVIDIA
 nxp	NXP Semiconductors
 okaya	Okaya Electric America, Inc.
+olimex	Olimex
 onnn	ON Semiconductor Corp.
 opencores	OpenCores.org
 option	Option NV
-- 
2.6.4
