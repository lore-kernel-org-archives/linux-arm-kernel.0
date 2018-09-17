From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Mon, 17 Sep 2018 16:01:26 +0800
Subject: [PATCH v2 1/3] dt-bindings: arm: move berlin binding documentation
 to syna.txt
In-Reply-To: <20180917160015.05a1fc5b@xhacker.debian>
References: <20180917160015.05a1fc5b@xhacker.debian>
Message-ID: <20180917160126.49211da9@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move berlin binding documentation as part of transition from Marvell
berlin to Synaptics SoC.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/{marvell/marvell,berlin.txt => syna.txt}         | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/arm/{marvell/marvell,berlin.txt => syna.txt} (100%)

diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/syna.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/marvell/marvell,berlin.txt
rename to Documentation/devicetree/bindings/arm/syna.txt
-- 
2.19.0
