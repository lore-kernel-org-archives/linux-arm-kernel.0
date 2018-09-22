From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sat, 22 Sep 2018 17:09:59 +0200
Subject: [PATCH v2 1/5] dt-bindings: add vendor prefix for "Endless Mobile,
 Inc."
In-Reply-To: <20180922151003.4736-1-martin.blumenstingl@googlemail.com>
References: <20180922151003.4736-1-martin.blumenstingl@googlemail.com>
Message-ID: <20180922151003.4736-2-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Endless Mobile, Inc. started selling (small) computers in 2015.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 2c3fc512e746..1c63d2c2d48f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -114,6 +114,7 @@ elan	Elan Microelectronic Corp.
 embest	Shenzhen Embest Technology Co., Ltd.
 emmicro	EM Microelectronic
 emtrion	emtrion GmbH
+endless	Endless Mobile, Inc.
 energymicro	Silicon Laboratories (formerly Energy Micro AS)
 engicam	Engicam S.r.l.
 epcos	EPCOS AG
-- 
2.19.0
