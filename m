From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 27 Jan 2015 11:36:40 +0800
Subject: [PATCH v3 2/2] binding: wm8904: add new compatible string
In-Reply-To: <1422329800-28481-1-git-send-email-voice.shen@atmel.com>
References: <1422329800-28481-1-git-send-email-voice.shen@atmel.com>
Message-ID: <1422329800-28481-2-git-send-email-voice.shen@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The "wlf,wm8912" compatible string is used for wm8912, which
share driver with wm8904, however, the data type is different.

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Changes in v3: None
Changes in v2: None

 Documentation/devicetree/bindings/sound/wm8904.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/wm8904.txt b/Documentation/devicetree/bindings/sound/wm8904.txt
index e99f409..66bf261 100644
--- a/Documentation/devicetree/bindings/sound/wm8904.txt
+++ b/Documentation/devicetree/bindings/sound/wm8904.txt
@@ -3,7 +3,7 @@ WM8904 audio CODEC
 This device supports I2C only.
 
 Required properties:
-  - compatible: "wlf,wm8904"
+  - compatible: "wlf,wm8904" or "wlf,wm8912"
   - reg: the I2C address of the device.
   - clock-names: "mclk"
   - clocks: reference to
-- 
2.3.0.rc0
