From: gmbnomis@gmail.com (Simon Baatz)
Date: Thu, 31 Oct 2013 12:19:27 +0100
Subject: [PATCH] ARM: kirkwood: Cleanup comments in Sheevaplug dts files
Message-ID: <1383218367-4012-1-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
Hi,

just two fixes for silly copy and paste errors.

- Simon

 arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi |    2 +-
 arch/arm/boot/dts/kirkwood-sheevaplug.dts         |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
index 5696b63..c2bedb6 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug-common.dtsi
@@ -1,5 +1,5 @@
 /*
- * kirkwood-sheevaplug-common.dts - Common parts for Sheevaplugs
+ * kirkwood-sheevaplug-common.dtsi - Common parts for Sheevaplugs
  *
  * Copyright (C) 2013 Simon Baatz <gmbnomis@gmail.com>
  *
diff --git a/arch/arm/boot/dts/kirkwood-sheevaplug.dts b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
index bb61918..0de8278 100644
--- a/arch/arm/boot/dts/kirkwood-sheevaplug.dts
+++ b/arch/arm/boot/dts/kirkwood-sheevaplug.dts
@@ -1,5 +1,5 @@
 /*
- * kirkwood-sheevaplug-esata.dts - Device tree file for Sheevaplug
+ * kirkwood-sheevaplug.dts - Device tree file for Sheevaplug
  *
  * Copyright (C) 2013 Simon Baatz <gmbnomis@gmail.com>
  *
-- 
1.7.9.5
