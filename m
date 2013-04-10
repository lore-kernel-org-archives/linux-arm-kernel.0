From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 10 Apr 2013 11:17:24 +0200
Subject: [PATCH 2/2] ARM: at91: move dts to subdir
In-Reply-To: <1365585444-11520-1-git-send-email-plagnioj@jcrosoft.com>
References: <1365585444-11520-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1365585444-11520-2-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Olof Johansson <olof@lixom.net>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/Makefile                         |   42 +++++---------------
 arch/arm/boot/dts/at91/Makefile                    |   38 ++++++++++++++++++
 arch/arm/boot/dts/{ => at91}/aks-cdu.dts           |    0
 arch/arm/boot/dts/{ => at91}/animeo_ip.dts         |    0
 arch/arm/boot/dts/{ => at91}/at91rm9200.dtsi       |    2 +-
 arch/arm/boot/dts/{ => at91}/at91rm9200ek.dts      |    0
 arch/arm/boot/dts/{ => at91}/at91sam9260.dtsi      |    2 +-
 arch/arm/boot/dts/{ => at91}/at91sam9263.dtsi      |    2 +-
 arch/arm/boot/dts/{ => at91}/at91sam9263ek.dts     |    0
 arch/arm/boot/dts/{ => at91}/at91sam9g15.dtsi      |    0
 arch/arm/boot/dts/{ => at91}/at91sam9g15ek.dts     |    0
 arch/arm/boot/dts/{ => at91}/at91sam9g20.dtsi      |    0
 arch/arm/boot/dts/{ => at91}/at91sam9g20ek.dts     |    0
 .../arm/boot/dts/{ => at91}/at91sam9g20ek_2mmc.dts |    0
 .../boot/dts/{ => at91}/at91sam9g20ek_common.dtsi  |    0
 arch/arm/boot/dts/{ => at91}/at91sam9g25.dtsi      |    0
 arch/arm/boot/dts/{ => at91}/at91sam9g25ek.dts     |    0
 arch/arm/boot/dts/{ => at91}/at91sam9g35.dtsi      |    0
 arch/arm/boot/dts/{ => at91}/at91sam9g35ek.dts     |    0
 arch/arm/boot/dts/{ => at91}/at91sam9g45.dtsi      |    2 +-
 arch/arm/boot/dts/{ => at91}/at91sam9m10g45ek.dts  |    0
 arch/arm/boot/dts/{ => at91}/at91sam9n12.dtsi      |    2 +-
 arch/arm/boot/dts/{ => at91}/at91sam9n12ek.dts     |    0
 arch/arm/boot/dts/{ => at91}/at91sam9x25.dtsi      |    0
 arch/arm/boot/dts/{ => at91}/at91sam9x25ek.dts     |    0
 arch/arm/boot/dts/{ => at91}/at91sam9x35.dtsi      |    0
 arch/arm/boot/dts/{ => at91}/at91sam9x35ek.dts     |    0
 arch/arm/boot/dts/{ => at91}/at91sam9x5.dtsi       |    2 +-
 arch/arm/boot/dts/{ => at91}/at91sam9x5cm.dtsi     |    0
 arch/arm/boot/dts/{ => at91}/at91sam9x5ek.dtsi     |    0
 arch/arm/boot/dts/{ => at91}/ethernut5.dts         |    0
 arch/arm/boot/dts/{ => at91}/evk-pro3.dts          |    0
 arch/arm/boot/dts/{ => at91}/ge863-pro3.dtsi       |    0
 arch/arm/boot/dts/{ => at91}/kizbox.dts            |    0
 arch/arm/boot/dts/{ => at91}/pm9g45.dts            |    0
 arch/arm/boot/dts/{ => at91}/tny_a9260.dts         |    0
 arch/arm/boot/dts/{ => at91}/tny_a9260_common.dtsi |    0
 arch/arm/boot/dts/{ => at91}/tny_a9263.dts         |    0
 arch/arm/boot/dts/{ => at91}/tny_a9g20.dts         |    0
 arch/arm/boot/dts/{ => at91}/usb_a9260.dts         |    0
 arch/arm/boot/dts/{ => at91}/usb_a9260_common.dtsi |    0
 arch/arm/boot/dts/{ => at91}/usb_a9263.dts         |    0
 .../arm/boot/dts/{ => at91}/usb_a9g20-dab-mmx.dtsi |    0
 arch/arm/boot/dts/{ => at91}/usb_a9g20.dts         |    0
 44 files changed, 54 insertions(+), 38 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91/Makefile
 rename arch/arm/boot/dts/{ => at91}/aks-cdu.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/animeo_ip.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/at91rm9200.dtsi (99%)
 rename arch/arm/boot/dts/{ => at91}/at91rm9200ek.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9260.dtsi (99%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9263.dtsi (99%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9263ek.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9g15.dtsi (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9g15ek.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9g20.dtsi (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9g20ek.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9g20ek_2mmc.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9g20ek_common.dtsi (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9g25.dtsi (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9g25ek.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9g35.dtsi (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9g35ek.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9g45.dtsi (99%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9m10g45ek.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9n12.dtsi (99%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9n12ek.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9x25.dtsi (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9x25ek.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9x35.dtsi (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9x35ek.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9x5.dtsi (99%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9x5cm.dtsi (100%)
 rename arch/arm/boot/dts/{ => at91}/at91sam9x5ek.dtsi (100%)
 rename arch/arm/boot/dts/{ => at91}/ethernut5.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/evk-pro3.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/ge863-pro3.dtsi (100%)
 rename arch/arm/boot/dts/{ => at91}/kizbox.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/pm9g45.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/tny_a9260.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/tny_a9260_common.dtsi (100%)
 rename arch/arm/boot/dts/{ => at91}/tny_a9263.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/tny_a9g20.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/usb_a9260.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/usb_a9260_common.dtsi (100%)
 rename arch/arm/boot/dts/{ => at91}/usb_a9263.dts (100%)
 rename arch/arm/boot/dts/{ => at91}/usb_a9g20-dab-mmx.dtsi (100%)
 rename arch/arm/boot/dts/{ => at91}/usb_a9g20.dts (100%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 2fa303d..a6a34f8 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -2,37 +2,8 @@ ifeq ($(CONFIG_OF),y)
 
 # Keep dtb files sorted alphabetically for each ARCH/SoC
 
-# at91
-# rm9200
-dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
-# sam9260
-dtb-$(CONFIG_ARCH_AT91) += animeo_ip.dtb
-dtb-$(CONFIG_ARCH_AT91) += aks-cdu.dtb
-dtb-$(CONFIG_ARCH_AT91) += ethernut5.dtb
-dtb-$(CONFIG_ARCH_AT91) += evk-pro3.dtb
-dtb-$(CONFIG_ARCH_AT91) += tny_a9260.dtb
-dtb-$(CONFIG_ARCH_AT91) += usb_a9260.dtb
-# sam9263
-dtb-$(CONFIG_ARCH_AT91) += at91sam9263ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += tny_a9263.dtb
-dtb-$(CONFIG_ARCH_AT91) += usb_a9263.dtb
-# sam9g20
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g20ek_2mmc.dtb
-dtb-$(CONFIG_ARCH_AT91) += kizbox.dtb
-dtb-$(CONFIG_ARCH_AT91) += tny_a9g20.dtb
-dtb-$(CONFIG_ARCH_AT91) += usb_a9g20.dtb
-# sam9g45
-dtb-$(CONFIG_ARCH_AT91) += at91sam9m10g45ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += pm9g45.dtb
-# sam9n12
-dtb-$(CONFIG_ARCH_AT91) += at91sam9n12ek.dtb
-# sam9x5
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g15ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g25ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9g35ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9x25ek.dtb
-dtb-$(CONFIG_ARCH_AT91) += at91sam9x35ek.dtb
+#at91
+dtb-$(CONFIG_ARCH_AT91) += at91/
 
 # bcm2835
 dtb-$(CONFIG_ARCH_BCM2835) += bcm2835-rpi-b.dtb
@@ -260,9 +231,16 @@ targets += dtbs
 targets += $(dtb-y)
 endif
 
+__dtb_subdir-y	:= $(patsubst %/, %/dtbs, $(filter %/, $(dtb-y)))
+dtb_subdir-y	:= $(addprefix $(obj)/, $(__dtb_subdir-y))
+
 # *.dtb used to be generated in the directory above. Clean out the
 # old build results so people don't accidentally use them.
-dtbs: $(addprefix $(obj)/, $(dtb-y))
+dtbs: $(addprefix $(obj)/, $(dtb-y)) $(dtb_subdir-y)
 	$(Q)rm -f $(obj)/../*.dtb
 
+$(dtb_subdir-y):
+	$(Q)rm -f `dirname $@`/*.dtb
+	$(Q)$(MAKE) $(build)=`dirname $@` dtbs
+
 clean-files := *.dtb
diff --git a/arch/arm/boot/dts/at91/Makefile b/arch/arm/boot/dts/at91/Makefile
new file mode 100644
index 0000000..d14a410
--- /dev/null
+++ b/arch/arm/boot/dts/at91/Makefile
@@ -0,0 +1,38 @@
+# Keep dtb files sorted alphabetically for each SoC
+
+# at91
+# rm9200
+dtb-y += at91rm9200ek.dtb
+# sam9260
+dtb-y += animeo_ip.dtb
+dtb-y += aks-cdu.dtb
+dtb-y += ethernut5.dtb
+dtb-y += evk-pro3.dtb
+dtb-y += tny_a9260.dtb
+dtb-y += usb_a9260.dtb
+# sam9263
+dtb-y += at91sam9263ek.dtb
+dtb-y += tny_a9263.dtb
+dtb-y += usb_a9263.dtb
+# sam9g20
+dtb-y += at91sam9g20ek.dtb
+dtb-y += at91sam9g20ek_2mmc.dtb
+dtb-y += kizbox.dtb
+dtb-y += tny_a9g20.dtb
+dtb-y += usb_a9g20.dtb
+# sam9g45
+dtb-y += at91sam9m10g45ek.dtb
+dtb-y += pm9g45.dtb
+# sam9n12
+dtb-y += at91sam9n12ek.dtb
+# sam9x5
+dtb-y += at91sam9g15ek.dtb
+dtb-y += at91sam9g25ek.dtb
+dtb-y += at91sam9g35ek.dtb
+dtb-y += at91sam9x25ek.dtb
+dtb-y += at91sam9x35ek.dtb
+
+targets += dtbs
+targets += $(dtb-y)
+
+dtbs: $(addprefix $(obj)/, $(dtb-y))
diff --git a/arch/arm/boot/dts/aks-cdu.dts b/arch/arm/boot/dts/at91/aks-cdu.dts
similarity index 100%
rename from arch/arm/boot/dts/aks-cdu.dts
rename to arch/arm/boot/dts/at91/aks-cdu.dts
diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/at91/animeo_ip.dts
similarity index 100%
rename from arch/arm/boot/dts/animeo_ip.dts
rename to arch/arm/boot/dts/at91/animeo_ip.dts
diff --git a/arch/arm/boot/dts/at91rm9200.dtsi b/arch/arm/boot/dts/at91/at91rm9200.dtsi
similarity index 99%
rename from arch/arm/boot/dts/at91rm9200.dtsi
rename to arch/arm/boot/dts/at91/at91rm9200.dtsi
index b0268a5..6962e75 100644
--- a/arch/arm/boot/dts/at91rm9200.dtsi
+++ b/arch/arm/boot/dts/at91/at91rm9200.dtsi
@@ -10,7 +10,7 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
+/include/ "../skeleton.dtsi"
 
 / {
 	model = "Atmel AT91RM9200 family SoC";
diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91/at91rm9200ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91rm9200ek.dts
rename to arch/arm/boot/dts/at91/at91rm9200ek.dts
diff --git a/arch/arm/boot/dts/at91sam9260.dtsi b/arch/arm/boot/dts/at91/at91sam9260.dtsi
similarity index 99%
rename from arch/arm/boot/dts/at91sam9260.dtsi
rename to arch/arm/boot/dts/at91/at91sam9260.dtsi
index cb7bcc5..3f8213b 100644
--- a/arch/arm/boot/dts/at91sam9260.dtsi
+++ b/arch/arm/boot/dts/at91/at91sam9260.dtsi
@@ -8,7 +8,7 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
+/include/ "../skeleton.dtsi"
 
 / {
 	model = "Atmel AT91SAM9260 family SoC";
diff --git a/arch/arm/boot/dts/at91sam9263.dtsi b/arch/arm/boot/dts/at91/at91sam9263.dtsi
similarity index 99%
rename from arch/arm/boot/dts/at91sam9263.dtsi
rename to arch/arm/boot/dts/at91/at91sam9263.dtsi
index d8146bb6..db3ffe4 100644
--- a/arch/arm/boot/dts/at91sam9263.dtsi
+++ b/arch/arm/boot/dts/at91/at91sam9263.dtsi
@@ -6,7 +6,7 @@
  * Licensed under GPLv2 only.
  */
 
-/include/ "skeleton.dtsi"
+/include/ "../skeleton.dtsi"
 
 / {
 	model = "Atmel AT91SAM9263 family SoC";
diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91/at91sam9263ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9263ek.dts
rename to arch/arm/boot/dts/at91/at91sam9263ek.dts
diff --git a/arch/arm/boot/dts/at91sam9g15.dtsi b/arch/arm/boot/dts/at91/at91sam9g15.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g15.dtsi
rename to arch/arm/boot/dts/at91/at91sam9g15.dtsi
diff --git a/arch/arm/boot/dts/at91sam9g15ek.dts b/arch/arm/boot/dts/at91/at91sam9g15ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g15ek.dts
rename to arch/arm/boot/dts/at91/at91sam9g15ek.dts
diff --git a/arch/arm/boot/dts/at91sam9g20.dtsi b/arch/arm/boot/dts/at91/at91sam9g20.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g20.dtsi
rename to arch/arm/boot/dts/at91/at91sam9g20.dtsi
diff --git a/arch/arm/boot/dts/at91sam9g20ek.dts b/arch/arm/boot/dts/at91/at91sam9g20ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g20ek.dts
rename to arch/arm/boot/dts/at91/at91sam9g20ek.dts
diff --git a/arch/arm/boot/dts/at91sam9g20ek_2mmc.dts b/arch/arm/boot/dts/at91/at91sam9g20ek_2mmc.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g20ek_2mmc.dts
rename to arch/arm/boot/dts/at91/at91sam9g20ek_2mmc.dts
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91/at91sam9g20ek_common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g20ek_common.dtsi
rename to arch/arm/boot/dts/at91/at91sam9g20ek_common.dtsi
diff --git a/arch/arm/boot/dts/at91sam9g25.dtsi b/arch/arm/boot/dts/at91/at91sam9g25.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g25.dtsi
rename to arch/arm/boot/dts/at91/at91sam9g25.dtsi
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91/at91sam9g25ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g25ek.dts
rename to arch/arm/boot/dts/at91/at91sam9g25ek.dts
diff --git a/arch/arm/boot/dts/at91sam9g35.dtsi b/arch/arm/boot/dts/at91/at91sam9g35.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g35.dtsi
rename to arch/arm/boot/dts/at91/at91sam9g35.dtsi
diff --git a/arch/arm/boot/dts/at91sam9g35ek.dts b/arch/arm/boot/dts/at91/at91sam9g35ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9g35ek.dts
rename to arch/arm/boot/dts/at91/at91sam9g35ek.dts
diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91/at91sam9g45.dtsi
similarity index 99%
rename from arch/arm/boot/dts/at91sam9g45.dtsi
rename to arch/arm/boot/dts/at91/at91sam9g45.dtsi
index bc103bc..58ce2a1 100644
--- a/arch/arm/boot/dts/at91sam9g45.dtsi
+++ b/arch/arm/boot/dts/at91/at91sam9g45.dtsi
@@ -9,7 +9,7 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
+/include/ "../skeleton.dtsi"
 
 / {
 	model = "Atmel AT91SAM9G45 family SoC";
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91/at91sam9m10g45ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9m10g45ek.dts
rename to arch/arm/boot/dts/at91/at91sam9m10g45ek.dts
diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91/at91sam9n12.dtsi
similarity index 99%
rename from arch/arm/boot/dts/at91sam9n12.dtsi
rename to arch/arm/boot/dts/at91/at91sam9n12.dtsi
index 7750f98..2ae88c1 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91/at91sam9n12.dtsi
@@ -7,7 +7,7 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
+/include/ "../skeleton.dtsi"
 
 / {
 	model = "Atmel AT91SAM9N12 SoC";
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91/at91sam9n12ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9n12ek.dts
rename to arch/arm/boot/dts/at91/at91sam9n12ek.dts
diff --git a/arch/arm/boot/dts/at91sam9x25.dtsi b/arch/arm/boot/dts/at91/at91sam9x25.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x25.dtsi
rename to arch/arm/boot/dts/at91/at91sam9x25.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x25ek.dts b/arch/arm/boot/dts/at91/at91sam9x25ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x25ek.dts
rename to arch/arm/boot/dts/at91/at91sam9x25ek.dts
diff --git a/arch/arm/boot/dts/at91sam9x35.dtsi b/arch/arm/boot/dts/at91/at91sam9x35.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x35.dtsi
rename to arch/arm/boot/dts/at91/at91sam9x35.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x35ek.dts b/arch/arm/boot/dts/at91/at91sam9x35ek.dts
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x35ek.dts
rename to arch/arm/boot/dts/at91/at91sam9x35ek.dts
diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91/at91sam9x5.dtsi
similarity index 99%
rename from arch/arm/boot/dts/at91sam9x5.dtsi
rename to arch/arm/boot/dts/at91/at91sam9x5.dtsi
index a98c0d5..a7966a8 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91/at91sam9x5.dtsi
@@ -9,7 +9,7 @@
  * Licensed under GPLv2 or later.
  */
 
-/include/ "skeleton.dtsi"
+/include/ "../skeleton.dtsi"
 
 / {
 	model = "Atmel AT91SAM9x5 family SoC";
diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91/at91sam9x5cm.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x5cm.dtsi
rename to arch/arm/boot/dts/at91/at91sam9x5cm.dtsi
diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91/at91sam9x5ek.dtsi
similarity index 100%
rename from arch/arm/boot/dts/at91sam9x5ek.dtsi
rename to arch/arm/boot/dts/at91/at91sam9x5ek.dtsi
diff --git a/arch/arm/boot/dts/ethernut5.dts b/arch/arm/boot/dts/at91/ethernut5.dts
similarity index 100%
rename from arch/arm/boot/dts/ethernut5.dts
rename to arch/arm/boot/dts/at91/ethernut5.dts
diff --git a/arch/arm/boot/dts/evk-pro3.dts b/arch/arm/boot/dts/at91/evk-pro3.dts
similarity index 100%
rename from arch/arm/boot/dts/evk-pro3.dts
rename to arch/arm/boot/dts/at91/evk-pro3.dts
diff --git a/arch/arm/boot/dts/ge863-pro3.dtsi b/arch/arm/boot/dts/at91/ge863-pro3.dtsi
similarity index 100%
rename from arch/arm/boot/dts/ge863-pro3.dtsi
rename to arch/arm/boot/dts/at91/ge863-pro3.dtsi
diff --git a/arch/arm/boot/dts/kizbox.dts b/arch/arm/boot/dts/at91/kizbox.dts
similarity index 100%
rename from arch/arm/boot/dts/kizbox.dts
rename to arch/arm/boot/dts/at91/kizbox.dts
diff --git a/arch/arm/boot/dts/pm9g45.dts b/arch/arm/boot/dts/at91/pm9g45.dts
similarity index 100%
rename from arch/arm/boot/dts/pm9g45.dts
rename to arch/arm/boot/dts/at91/pm9g45.dts
diff --git a/arch/arm/boot/dts/tny_a9260.dts b/arch/arm/boot/dts/at91/tny_a9260.dts
similarity index 100%
rename from arch/arm/boot/dts/tny_a9260.dts
rename to arch/arm/boot/dts/at91/tny_a9260.dts
diff --git a/arch/arm/boot/dts/tny_a9260_common.dtsi b/arch/arm/boot/dts/at91/tny_a9260_common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/tny_a9260_common.dtsi
rename to arch/arm/boot/dts/at91/tny_a9260_common.dtsi
diff --git a/arch/arm/boot/dts/tny_a9263.dts b/arch/arm/boot/dts/at91/tny_a9263.dts
similarity index 100%
rename from arch/arm/boot/dts/tny_a9263.dts
rename to arch/arm/boot/dts/at91/tny_a9263.dts
diff --git a/arch/arm/boot/dts/tny_a9g20.dts b/arch/arm/boot/dts/at91/tny_a9g20.dts
similarity index 100%
rename from arch/arm/boot/dts/tny_a9g20.dts
rename to arch/arm/boot/dts/at91/tny_a9g20.dts
diff --git a/arch/arm/boot/dts/usb_a9260.dts b/arch/arm/boot/dts/at91/usb_a9260.dts
similarity index 100%
rename from arch/arm/boot/dts/usb_a9260.dts
rename to arch/arm/boot/dts/at91/usb_a9260.dts
diff --git a/arch/arm/boot/dts/usb_a9260_common.dtsi b/arch/arm/boot/dts/at91/usb_a9260_common.dtsi
similarity index 100%
rename from arch/arm/boot/dts/usb_a9260_common.dtsi
rename to arch/arm/boot/dts/at91/usb_a9260_common.dtsi
diff --git a/arch/arm/boot/dts/usb_a9263.dts b/arch/arm/boot/dts/at91/usb_a9263.dts
similarity index 100%
rename from arch/arm/boot/dts/usb_a9263.dts
rename to arch/arm/boot/dts/at91/usb_a9263.dts
diff --git a/arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi b/arch/arm/boot/dts/at91/usb_a9g20-dab-mmx.dtsi
similarity index 100%
rename from arch/arm/boot/dts/usb_a9g20-dab-mmx.dtsi
rename to arch/arm/boot/dts/at91/usb_a9g20-dab-mmx.dtsi
diff --git a/arch/arm/boot/dts/usb_a9g20.dts b/arch/arm/boot/dts/at91/usb_a9g20.dts
similarity index 100%
rename from arch/arm/boot/dts/usb_a9g20.dts
rename to arch/arm/boot/dts/at91/usb_a9g20.dts
-- 
1.7.10.4
