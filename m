From: peda@axentia.se (Peter Rosin)
Date: Fri,  1 Dec 2017 23:44:24 +0100
Subject: [PATCH 1/2] dt-bindings: trivial: add tfa9879 device
In-Reply-To: <20171201224425.5477-1-peda@axentia.se>
References: <20171201224425.5477-1-peda@axentia.se>
Message-ID: <20171201224425.5477-2-peda@axentia.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add record for NXP TFA9879 Mono BTL Class D audio amplifier.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 Documentation/devicetree/bindings/trivial-devices.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index af284fbd4d23..4cf30ce4e71f 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -157,6 +157,7 @@ nxp,pcf2127		Real-time clock
 nxp,pcf2129		Real-time clock
 nxp,pcf8563		Real-time clock/calendar
 nxp,pcf85063		Tiny Real-Time Clock
+nxp,tfa9879		Mono BTL Class D audio amplifier
 oki,ml86v7667		OKI ML86V7667 video decoder
 ovti,ov5642		OV5642: Color CMOS QSXGA (5-megapixel) Image Sensor with OmniBSI and Embedded TrueFocus
 pericom,pt7c4338	Real-time Clock Module
-- 
2.11.0
