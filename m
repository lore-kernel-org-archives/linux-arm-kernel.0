From: andrew.ruder@elecsyscorp.com (Andrew Ruder)
Date: Thu,  5 Jun 2014 14:27:05 -0500
Subject: [PATCH 3/6] arm: pxa27x.dtsi: header typo - wrong file
In-Reply-To: <cover.1401995177.git.andrew.ruder@elecsyscorp.com>
References: <cover.1401995177.git.andrew.ruder@elecsyscorp.com>
Message-ID: <ceb96637accd7da382ba8bfd0c8327a72cd97ccf.1401995177.git.andrew.ruder@elecsyscorp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixing a copy-paste error calling this file the pxa3xx skeleton when it
is actually the pxa27x skeleton.

Signed-off-by: Andrew Ruder <andrew.ruder@elecsyscorp.com>
---
 arch/arm/boot/dts/pxa27x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index a705469..931e1d5 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -1,4 +1,4 @@
-/* The pxa3xx skeleton simply augments the 2xx version */
+/* The pxa27x skeleton simply augments the 2xx version */
 /include/ "pxa2xx.dtsi"
 
 / {
-- 
1.9.0.rc3.12.gbc97e2d
