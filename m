From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 17 Jun 2014 18:41:43 +0200
Subject: [PATCH 1/6] ARM: at91/dt: define sam9261ek slow crystal frequency
In-Reply-To: <1403023308-20533-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1403023308-20533-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1403023308-20533-2-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define at91sam9261ek's slow crystal frequencies.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9261ek.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index c6683ea8b743..aa35a7aec9a8 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -20,6 +20,10 @@
 		reg = <0x20000000 0x4000000>;
 	};
 
+	slow_xtal {
+		clock-frequency = <32768>;
+	};
+
 	main_xtal {
 		clock-frequency = <18432000>;
 	};
-- 
1.9.1
