From: Jisheng.Zhang@synaptics.com (Jisheng Zhang)
Date: Fri, 13 Jul 2018 17:18:59 +0800
Subject: [PATCH 1/3] dt-bindings: arm: move berlin binding documentation to
 syna.txt
In-Reply-To: <20180713171712.05f58a74@xhacker.debian>
References: <20180713171712.05f58a74@xhacker.debian>
Message-ID: <20180713171859.6c4e5a35@xhacker.debian>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move berlin binding documentation as part of transition from Marvell
berlin to Synaptics SoC.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 .../bindings/arm/{marvell/marvell,berlin.txt => syna.txt}         | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/arm/{marvell/marvell,berlin.txt => syna.txt} (100%)

diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,berlin.txt b/Documentation/devicetree/bindings/arm/syna.txt
similarity index 100%
rename from Documentation/devicetree/bindings/arm/marvell/marvell,berlin.txt
rename to Documentation/devicetree/bindings/arm/syna.txt
-- 
2.18.0
