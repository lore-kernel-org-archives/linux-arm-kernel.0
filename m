From: andrew@lunn.ch (Andrew Lunn)
Date: Sun,  6 Jan 2013 11:10:42 +0100
Subject: [PATCH 09/11] arm: mvebu: Add missing ; for cpu node.
In-Reply-To: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
References: <1357467044-4914-1-git-send-email-andrew@lunn.ch>
Message-ID: <1357467044-4914-10-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Armada XP MV78230 DT include file is missing a ; at the
end of the cpu node.

Reported-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/armada-xp-mv78230.dtsi b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
index 8f90fac..271855a 100644
--- a/arch/arm/boot/dts/armada-xp-mv78230.dtsi
+++ b/arch/arm/boot/dts/armada-xp-mv78230.dtsi
@@ -41,7 +41,7 @@
 		reg = <1>;
 		clocks = <&cpuclk 1>;
 	    };
-	}
+	};
 
 	soc {
 		pinctrl {
-- 
1.7.10.4
