From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sun, 18 May 2014 21:02:17 -0300
Subject: [PATCH] irqchip: armada-370-xp: Move the devicetree binding
 documentation
Message-ID: <1400457737-1617-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the devicetree binding documentation to the interrupt-controller
directory, where it belongs.

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 .../marvell,armada-370-xp-mpic.txt}                                       | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/{arm/armada-370-xp-mpic.txt => interrupt-controller/marvell,armada-370-xp-mpic.txt} (100%)

diff --git a/Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/armada-370-xp-mpic.txt
rename to Documentation/devicetree/bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt
-- 
1.9.1
