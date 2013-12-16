From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Mon, 16 Dec 2013 21:24:17 +0100
Subject: [RFC PATCH 06/10] irqchip: atmel-aic: move binding doc to
 interrupt-controller directory
In-Reply-To: <1387225461-6201-1-git-send-email-b.brezillon@overkiz.com>
References: <1387225461-6201-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1387225461-6201-7-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move atmel aic driver doc to the interrupt-controller directory as the new
driver now lays in drivers/irqchip/atmel-aic.c.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 .../atmel,aic.txt}                                 |    0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{arm/atmel-aic.txt => interrupt-controller/atmel,aic.txt} (100%)

diff --git a/Documentation/devicetree/bindings/arm/atmel-aic.txt b/Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/atmel-aic.txt
rename to Documentation/devicetree/bindings/interrupt-controller/atmel,aic.txt
-- 
1.7.9.5
