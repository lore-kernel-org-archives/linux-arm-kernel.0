From: boris.brezillon@free-electrons.com (Boris BREZILLON)
Date: Thu, 10 Jul 2014 19:14:17 +0200
Subject: [PATCH v4 2/7] irqchip: atmel-aic: move binding doc to
 interrupt-controller directory
In-Reply-To: <1405012462-766-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1405012462-766-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <1405012462-766-3-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move atmel aic driver doc to the interrupt-controller directory as the new
driver now lays in drivers/irqchip/atmel-aic.c.

Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 .../bindings/{arm/atmel-aic.txt => interrupt-controller/atmel,aic.txt}    | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{arm/atmel-aic.txt => interrupt-controller/atmel,aic.txt} (100%)

diff --git a/Documentation/devicetree/bindings/arm/atmel-aic.txt b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/atmel-aic.txt
rename to Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
-- 
1.8.3.2
