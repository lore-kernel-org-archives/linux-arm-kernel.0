From: andrew@aj.id.au (Andrew Jeffery)
Date: Tue,  6 Dec 2016 13:53:21 +1100
Subject: [PATCH v3 6/6] mfd: dt: Move syscon bindings to syscon subdirectory
In-Reply-To: <20161206025321.1792-1-andrew@aj.id.au>
References: <20161206025321.1792-1-andrew@aj.id.au>
Message-ID: <20161206025321.1792-7-andrew@aj.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The use of syscons is growing, lets collate them in their own part of
the bindings tree.

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 Documentation/devicetree/bindings/mfd/{ => syscon}/aspeed-scu.txt         | 0
 Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-gpbr.txt         | 0
 Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-matrix.txt       | 0
 Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-smc.txt          | 0
 Documentation/devicetree/bindings/mfd/{ => syscon}/qcom,tcsr.txt          | 0
 Documentation/devicetree/bindings/mfd/{ => syscon}/syscon.txt             | 0
 .../devicetree/bindings/mfd/{ => syscon}/ti-keystone-devctrl.txt          | 0
 7 files changed, 0 insertions(+), 0 deletions(-)
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/aspeed-scu.txt (100%)
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-gpbr.txt (100%)
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-matrix.txt (100%)
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/atmel-smc.txt (100%)
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/qcom,tcsr.txt (100%)
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/syscon.txt (100%)
 rename Documentation/devicetree/bindings/mfd/{ => syscon}/ti-keystone-devctrl.txt (100%)

diff --git a/Documentation/devicetree/bindings/mfd/aspeed-scu.txt b/Documentation/devicetree/bindings/mfd/syscon/aspeed-scu.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mfd/aspeed-scu.txt
rename to Documentation/devicetree/bindings/mfd/syscon/aspeed-scu.txt
diff --git a/Documentation/devicetree/bindings/mfd/atmel-gpbr.txt b/Documentation/devicetree/bindings/mfd/syscon/atmel-gpbr.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mfd/atmel-gpbr.txt
rename to Documentation/devicetree/bindings/mfd/syscon/atmel-gpbr.txt
diff --git a/Documentation/devicetree/bindings/mfd/atmel-matrix.txt b/Documentation/devicetree/bindings/mfd/syscon/atmel-matrix.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mfd/atmel-matrix.txt
rename to Documentation/devicetree/bindings/mfd/syscon/atmel-matrix.txt
diff --git a/Documentation/devicetree/bindings/mfd/atmel-smc.txt b/Documentation/devicetree/bindings/mfd/syscon/atmel-smc.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mfd/atmel-smc.txt
rename to Documentation/devicetree/bindings/mfd/syscon/atmel-smc.txt
diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.txt b/Documentation/devicetree/bindings/mfd/syscon/qcom,tcsr.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mfd/qcom,tcsr.txt
rename to Documentation/devicetree/bindings/mfd/syscon/qcom,tcsr.txt
diff --git a/Documentation/devicetree/bindings/mfd/syscon.txt b/Documentation/devicetree/bindings/mfd/syscon/syscon.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mfd/syscon.txt
rename to Documentation/devicetree/bindings/mfd/syscon/syscon.txt
diff --git a/Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt b/Documentation/devicetree/bindings/mfd/syscon/ti-keystone-devctrl.txt
similarity index 100%
rename from Documentation/devicetree/bindings/mfd/ti-keystone-devctrl.txt
rename to Documentation/devicetree/bindings/mfd/syscon/ti-keystone-devctrl.txt
-- 
2.9.3
