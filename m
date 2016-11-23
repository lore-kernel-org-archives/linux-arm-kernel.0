From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Wed, 23 Nov 2016 20:29:36 +0300
Subject: [PATCH 8/9] dt-bindings: add rockchip,
 clocksource property to rk-timer
In-Reply-To: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
References: <1479922177-20136-1-git-send-email-al.kochet@gmail.com>
Message-ID: <1479922177-20136-8-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 .../bindings/timer/rockchip,rk-timer.txt           |    1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
index a41b184..ed5392a 100644
--- a/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/rockchip,rk-timer.txt
@@ -9,6 +9,7 @@ Required properties:
 - clocks : must contain an entry for each entry in clock-names
 - clock-names : must include the following entries:
   "timer", "pclk"
+- rockchip,clocksource: setup the timer as clocksource
 
 Example:
 	timer: timer at ff810000 {
-- 
1.7.9.5
