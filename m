From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed, 20 Apr 2016 17:32:18 +0200
Subject: [PATCH 13/14] rtc: rtc-sa1100: DT spelling
 s/interrupt-name/interrupt-names/
In-Reply-To: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
References: <1461166339-11109-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1461166339-11109-14-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 Documentation/devicetree/bindings/rtc/sa1100-rtc.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/rtc/sa1100-rtc.txt b/Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
index 0cda19ad4859c541..968ac820254bbbae 100644
--- a/Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
+++ b/Documentation/devicetree/bindings/rtc/sa1100-rtc.txt
@@ -13,5 +13,5 @@ Example:
 		compatible = "mrvl,mmp-rtc";
 		reg = <0xd4010000 0x1000>;
 		interrupts = <5>, <6>;
-		interrupt-name = "rtc 1Hz", "rtc alarm";
+		interrupt-names = "rtc 1Hz", "rtc alarm";
 	};
-- 
1.9.1
