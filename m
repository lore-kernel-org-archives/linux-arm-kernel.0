From: jm@lentin.co.uk (Jamie Lentin)
Date: Fri, 26 Aug 2016 10:21:00 +0100
Subject: [PATCH 4/8] arm: orion5x: Alias uart0 to serial0 for all orion5x
In-Reply-To: <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
References: <1468679348-10522-1-git-send-email-jm@lentin.co.uk>
 <1472203264-21089-1-git-send-email-jm@lentin.co.uk>
Message-ID: <1472203264-21089-5-git-send-email-jm@lentin.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allowing us to specify boot console in a standard manner in board DTs.

Signed-off-by: Jamie Lentin <jm@lentin.co.uk>
---
 arch/arm/boot/dts/orion5x.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/orion5x.dtsi b/arch/arm/boot/dts/orion5x.dtsi
index fbccfbb..001613d 100644
--- a/arch/arm/boot/dts/orion5x.dtsi
+++ b/arch/arm/boot/dts/orion5x.dtsi
@@ -17,6 +17,7 @@
 
 	aliases {
 		gpio0 = &gpio0;
+		serial0 = &uart0;
 	};
 
 	soc {
-- 
2.8.1
