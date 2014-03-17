From: voice.shen@atmel.com (Bo Shen)
Date: Mon, 17 Mar 2014 17:45:35 +0800
Subject: [PATCH 2/8] ARM: at91: sama5d3: disable sound by default
In-Reply-To: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
References: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1395049541-28128-3-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make the sound device in disabled status by default

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---

 arch/arm/boot/dts/sama5d3xmb.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sama5d3xmb.dtsi b/arch/arm/boot/dts/sama5d3xmb.dtsi
index dba739b..2938605 100644
--- a/arch/arm/boot/dts/sama5d3xmb.dtsi
+++ b/arch/arm/boot/dts/sama5d3xmb.dtsi
@@ -170,5 +170,7 @@
 
 		atmel,ssc-controller = <&ssc0>;
 		atmel,audio-codec = <&wm8904>;
+
+		status = "disabled";
 	};
 };
-- 
1.8.5.2
