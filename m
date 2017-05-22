From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Mon, 22 May 2017 11:40:19 +0200
Subject: [PATCH 2/4] dt-bindings: i2c-mt6577: Rename file to reflect bindings
In-Reply-To: <20170522094021.7837-1-matthias.bgg@gmail.com>
References: <20170522094021.7837-1-matthias.bgg@gmail.com>
Message-ID: <20170522094021.7837-2-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2c-mt6577.txt actually holds the bindings for all mediatek supported i2c
controller. Change the name to i2c.mtk.txt to reflect that.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 Documentation/devicetree/bindings/i2c/{i2c-mt6577.txt => i2c-mtk.txt} | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/i2c/{i2c-mt6577.txt => i2c-mtk.txt} (100%)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mt6577.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
similarity index 100%
rename from Documentation/devicetree/bindings/i2c/i2c-mt6577.txt
rename to Documentation/devicetree/bindings/i2c/i2c-mtk.txt
-- 
2.12.0
