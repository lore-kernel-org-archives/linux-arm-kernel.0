From: chris.packham@alliedtelesis.co.nz (Chris Packham)
Date: Thu, 22 Nov 2018 13:11:38 +1300
Subject: [PATCH v7 5/9] dt-bindings: ARM: document marvell,ecc-enable binding
In-Reply-To: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
References: <20181122001142.19187-1-chris.packham@alliedtelesis.co.nz>
Message-ID: <20181122001142.19187-6-chris.packham@alliedtelesis.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add documentation for the marvell,ecc-enable properties which can be
used to enable ECC on the Marvell aurora cache.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Notes:
    Changes in v7:
    - remove marvell,ecc-disable
    Changes in v6:
    - new (split binding doc from implementation).

 Documentation/devicetree/bindings/arm/l2c2x0.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/l2c2x0.txt b/Documentation/devicetree/bindings/arm/l2c2x0.txt
index fbe6cb21f4cf..69e890d56392 100644
--- a/Documentation/devicetree/bindings/arm/l2c2x0.txt
+++ b/Documentation/devicetree/bindings/arm/l2c2x0.txt
@@ -76,6 +76,7 @@ Optional properties:
   specified to indicate that such transforms are precluded.
 - arm,parity-enable : enable parity checking on the L2 cache (L220 or PL310).
 - arm,parity-disable : disable parity checking on the L2 cache (L220 or PL310).
+- marvell,ecc-enable : enable ECC protection on the L2 cache
 - arm,outer-sync-disable : disable the outer sync operation on the L2 cache.
   Some core tiles, especially ARM PB11MPCore have a faulty L220 cache that
   will randomly hang unless outer sync operations are disabled.
-- 
2.19.1
