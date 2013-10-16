From: broonie@kernel.org (Mark Brown)
Date: Wed, 16 Oct 2013 12:04:07 +0100
Subject: [PATCH] MAINTAINERS: Add patterns for DTS files for AT91
Message-ID: <1381921447-21811-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Help ensure updates to the DTS files for AT91 machines and devices get
sent to the maintainers by adding patterns to the MAINTAINERS entry for
the architecture.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d5714d0..c610fb8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -777,6 +777,8 @@ W:	http://maxim.org.za/at91_26.html
 W:	http://www.linux4sam.org
 S:	Supported
 F:	arch/arm/mach-at91/
+F:	arch/arm/boot/dts/at91*.dts
+F:	arch/arm/boot/dts/at91*.dtsi
 
 ARM/CALXEDA HIGHBANK ARCHITECTURE
 M:	Rob Herring <rob.herring@calxeda.com>
-- 
1.8.4.rc3
