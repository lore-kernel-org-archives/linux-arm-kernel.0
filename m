From: bugalski.piotr@gmail.com (Piotr Bugalski)
Date: Mon,  5 Nov 2018 11:36:25 +0100
Subject: [PATCH v3 6/6] dt-bindings: spi: QuadSPI driver for Atmel SAMA5D2
In-Reply-To: <20181105103625.9644-1-bugalski.piotr@gmail.com>
References: <20181105103625.9644-1-bugalski.piotr@gmail.com>
Message-ID: <20181105103625.9644-7-bugalski.piotr@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Atmel SAMA5D2 QuadSPI driver was moved from mtd to spi subsystem,
this change is just moving DT-binding documentation.

Suggested-by: Boris Brezillon <boris.brezillon@bootlin.com>
Signed-off-by: Piotr Bugalski <bugalski.piotr@gmail.com>
---
 Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{mtd => spi}/atmel-quadspi.txt (100%)

diff --git a/Documentation/devicetree/bindings/mtd/atmel-quadspi.txt b/Documentation/devicetree/bindings/spi/atmel-quadspi.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mtd/atmel-quadspi.txt
rename to Documentation/devicetree/bindings/spi/atmel-quadspi.txt
-- 
2.11.0
