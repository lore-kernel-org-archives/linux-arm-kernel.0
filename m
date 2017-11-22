From: narmstrong@baylibre.com (Neil Armstrong)
Date: Wed, 22 Nov 2017 12:02:36 +0100
Subject: [PATCH v2 2/6] dt-bindings: Add vendor prefix for Solomon Goldentek
 Display Corporation
In-Reply-To: <1511348560-28505-1-git-send-email-narmstrong@baylibre.com>
References: <1511348560-28505-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1511348560-28505-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Solomon Goldentek Display Corporation is a Taiwanese LCD/LCM manufacturer.
Company Site: http://www.goldentek.com.tw

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 0994bdd..b0d3bef 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -305,6 +305,7 @@ seagate	Seagate Technology PLC
 semtech	Semtech Corporation
 sensirion	Sensirion AG
 sff	Small Form Factor Committee
+sgd	Solomon Goldentek Display Corporation
 sgx	SGX Sensortech
 sharp	Sharp Corporation
 shimafuji	Shimafuji Electric, Inc.
-- 
2.7.4
