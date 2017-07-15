From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 15 Jul 2017 19:50:54 +0200
Subject: [PATCH 3/5] MAINTAINERS: Update the Gemini maintainer list
In-Reply-To: <20170715175056.13040-1-linus.walleij@linaro.org>
References: <20170715175056.13040-1-linus.walleij@linaro.org>
Message-ID: <20170715175056.13040-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch:
- Adds myself as comaintainer for the Gemini.
- Adds the Gemini main bindings to the file list.
- Adds the pin controller plus bindings to the Gemini
  file list.
- Fixes up the path of the RTC binding and driver.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Hans: please ACK this if you're OK with it and I'll merge this
fixup along with the new pin control driver into my pin control
tree.
---
 MAINTAINERS | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad8107b47db..27c56bbba3a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1239,11 +1239,16 @@ S:	Maintained
 
 ARM/CORTINA SYSTEMS GEMINI ARM ARCHITECTURE
 M:	Hans Ulli Kroll <ulli.kroll@googlemail.com>
+M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-arm-kernel at lists.infradead.org (moderated for non-subscribers)
 T:	git git://github.com/ulli-kroll/linux.git
 S:	Maintained
+F:	Documentation/devicetree/bindings/arm/gemini.txt
+F:	Documentation/devicetree/bindings/pinctrl/cortina,gemini-pinctrl.txt
+F:	Documentation/devicetree/bindings/rtc/faraday,ftrtc010.txt
 F:	arch/arm/mach-gemini/
-F:	drivers/rtc/rtc-gemini.c
+F:	drivers/pinctrl/pinctrl-gemini.c
+F:	drivers/rtc/rtc-ftrtc010.c
 
 ARM/CSR SIRFPRIMA2 MACHINE SUPPORT
 M:	Barry Song <baohua@kernel.org>
-- 
2.9.4
