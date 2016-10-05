From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed,  5 Oct 2016 10:09:39 +0200
Subject: [PATCH v2 1/2] devicetree: Add vendor prefix for Nexbox
In-Reply-To: <1475654980-16414-1-git-send-email-narmstrong@baylibre.com>
References: <1475654980-16414-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1475654980-16414-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nexbox is an IPTV set-top-box distributor, mainly with Amlogic SoCs:
        https://www.inexbox.com

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index a9999a3..ecb360f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -182,6 +182,7 @@ neonode		Neonode Inc.
 netgear	NETGEAR
 netlogic	Broadcom Corporation (formerly NetLogic Microsystems)
 netxeon		Shenzhen Netxeon Technology CO., LTD
+nexbox	Nexbox
 newhaven	Newhaven Display International
 nintendo	Nintendo
 nokia	Nokia
-- 
1.9.1
