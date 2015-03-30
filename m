From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 30 Mar 2015 22:58:49 +0100
Subject: [PATCH v4 10/10] eeprom: Add to MAINTAINERS for eeprom framework
In-Reply-To: <1427752492-17039-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1427752492-17039-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1427752729-17474-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds MAINTAINERS to eeprom framework.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 358eb01..7094bb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3721,6 +3721,15 @@ T:	git git://git.alsa-project.org/alsa-kernel.git
 S:	Maintained
 F:	sound/usb/misc/ua101.c
 
+EEPROM FRAMEWORK
+M:	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+M:	Maxime Ripard <maxime.ripard@free-electrons.com>
+S:	Maintained
+F:	drivers/eeprom/
+F:	Documentation/devicetree/bindings/eeprom/
+F:	include/linux/eeprom-provider.h
+F:	include/linux/eeprom-consumer.h
+
 EXTENSIBLE FIRMWARE INTERFACE (EFI)
 M:	Matt Fleming <matt.fleming@intel.com>
 L:	linux-efi at vger.kernel.org
-- 
1.9.1
