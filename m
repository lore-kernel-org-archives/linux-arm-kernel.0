From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 29 Jan 2015 14:08:17 +0100
Subject: [PATCH 7/9] dt/bindings: Add binding for Versatile system registers
In-Reply-To: <1422536899-16609-1-git-send-email-daniel.lezcano@linaro.org>
References: <54CA3044.6070501@linaro.org>
 <1422536899-16609-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1422536899-16609-7-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

Add binding for Versatile board system registers found in the FPGA of the
Versatile/AB and Versatile/PB boards.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
Cc: Kumar Gala <galak@codeaurora.org>
Cc: devicetree at vger.kernel.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/arm/versatile-sysreg.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/versatile-sysreg.txt

diff --git a/Documentation/devicetree/bindings/arm/versatile-sysreg.txt b/Documentation/devicetree/bindings/arm/versatile-sysreg.txt
new file mode 100644
index 0000000..a4f1526
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/versatile-sysreg.txt
@@ -0,0 +1,10 @@
+ARM Versatile system registers
+--------------------------------------
+
+This is a system control registers block, providing multiple low level
+platform functions like board detection and identification, software
+interrupt generation, MMC and NOR Flash control etc.
+
+Required node properties:
+- compatible value : = "arm,versatile-sysreg", "syscon"
+- reg : physical base address and the size of the registers window
-- 
1.9.1
