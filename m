From: lho@apm.com (Loc Ho)
Date: Tue, 19 Jan 2016 19:27:41 -0700
Subject: [PATCH v2 1/3] Documentation: Update APM X-Gene clock binding for v2
 hardware
In-Reply-To: <1453256863-15092-1-git-send-email-lho@apm.com>
References: <1453256863-15092-1-git-send-email-lho@apm.com>
Message-ID: <1453256863-15092-2-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update APM X-Gene clock binding documentation for SoC and
PCP PLL for v2 hardware.

Signed-off-by: Loc Ho <lho@apm.com>
---
 Documentation/devicetree/bindings/clock/xgene.txt |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/xgene.txt b/Documentation/devicetree/bindings/clock/xgene.txt
index 1c4ef77..3fe3169 100644
--- a/Documentation/devicetree/bindings/clock/xgene.txt
+++ b/Documentation/devicetree/bindings/clock/xgene.txt
@@ -9,6 +9,8 @@ Required properties:
 	"apm,xgene-socpll-clock" - for a X-Gene SoC PLL clock
 	"apm,xgene-pcppll-clock" - for a X-Gene PCP PLL clock
 	"apm,xgene-device-clock" - for a X-Gene device clock
+	"apm,xgene-socpll-v2-clock" - for a X-Gene SoC PLL v2 clock
+	"apm,xgene-pcppll-v2-clock" - for a X-Gene PCP PLL v2 clock
 
 Required properties for SoC or PCP PLL clocks:
 - reg : shall be the physical PLL register address for the pll clock.
-- 
1.7.1
