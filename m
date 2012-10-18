From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 18 Oct 2012 17:07:04 +0800
Subject: [PATCH 10/10] document: devicetree: bind pinconf in pinctrl single
In-Reply-To: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
References: <1350551224-12857-1-git-send-email-haojian.zhuang@gmail.com>
Message-ID: <1350551224-12857-10-git-send-email-haojian.zhuang@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add comments with pinconf & gpio range in the document of
pinctrl-single.

Signed-off-by: Haojian Zhuang <haojian.zhuang@gmail.com>
---
 .../devicetree/bindings/pinctrl/pinctrl-single.txt |   43 ++++++++++++++++++++
 1 files changed, 43 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
index 5187f0d..b0e5059 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-single.txt
@@ -15,6 +15,49 @@ Optional properties:
   available and same for all registers; if not specified, disabling of
   pin functions is ignored
 
+- pinctrl-single,gpio-mask : mask of enabling gpio function register
+
+- pinctrl-single,gpio-ranges : gpio range list
+
+- pinctrl-single,gpio : array with gpio range start, size & register
+  offset
+
+- pinctrl-single,gpio-enable : value of enabling gpio function
+
+- pinctrl-single,gpio-disable : value of disabling gpio function
+
+- pinctrl-single,power-source-mask : mask of setting power source in
+  the pinmux register
+
+- pinctrl-single,power-source-shift : shift of power source field in
+  the pinmux register
+
+- pinctrl-single,power-source : value of setting power source field
+  in the pinmux register
+
+- pinctrl-single,bias-mask : mask of setting bias value in the pinmux
+  register
+
+- pinctrl-single,bias-shift : shift of setting bias value in the
+  pinmux register
+
+- pinctrl-single,bias-disable : value of disabling bias in the pinmux
+  register
+
+- pinctrl-single,bias-pull-down : value of setting bias pull down in
+  the pinmux register
+
+- pinctrl-single,bias-pull-up : value of setting bias pull up in the
+  pinmux register
+
+- pinctrl-single,bias : value of setting bias in the pinmux register
+
+- pinctrl-single,input-schmitt-mask : mask of setting input schmitt
+  in the pinmux register
+
+- pinctrl-single,input-schmitt-shift : shift of setting input schmitt
+  in the pinmux register
+
 This driver assumes that there is only one register for each pin,
 and uses the common pinctrl bindings as specified in the pinctrl-bindings.txt
 document in this directory.
-- 
1.7.0.4
