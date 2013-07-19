From: jonas.jensen@gmail.com (Jonas Jensen)
Date: Fri, 19 Jul 2013 13:12:59 +0200
Subject: [PATCH] ARM: clocksource: moxart: documentation: update device tree
 bindings document
In-Reply-To: <1374048297-4321-1-git-send-email-jonas.jensen@gmail.com>
References: <1374048297-4321-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <1374232379-20900-1-git-send-email-jonas.jensen@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update device tree bindings document with the correct clock name.

Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>
---

Notes:
    Hi Daniel,
    
    I apologize in advance if this causes trouble..
    
    One of the device tree bindings files you merged
    git://git.linaro.org/people/dlezcano/clockevents.git timers/clockevents-next
    now needs an update.
    
    This patch can be applied directly to timers/clockevents-next.
    
    Best regards,
    Jonas

 Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt b/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
index 77c4cfa..ad0bf7f 100644
--- a/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
+++ b/Documentation/devicetree/bindings/timer/moxa,moxart-timer.txt
@@ -5,7 +5,7 @@ Required properties:
 - compatible : Should be "moxa,moxart-timer"
 - reg : Should contain registers location and length
 - interrupts : Should contain the timer interrupt number
-- clocks : Should contain phandle for APB clock "clkapb"
+- clocks : Should contain phandle for the MOXA ART core clock "coreclk"
 
 Example:
 
@@ -13,5 +13,5 @@ Example:
 		compatible = "moxa,moxart-timer";
 		reg = <0x98400000 0x42>;
 		interrupts = <19 1>;
-		clocks = <&clkapb>;
+		clocks = <&coreclk>;
 	};
-- 
1.8.2.1
