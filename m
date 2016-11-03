From: narmstrong@baylibre.com (Neil Armstrong)
Date: Thu,  3 Nov 2016 10:11:23 +0100
Subject: [PATCH 1/2] ARM64: dts: meson-gxbb: Add generic legacy scpi compatible
In-Reply-To: <1478164284-24958-1-git-send-email-narmstrong@baylibre.com>
References: <1478164284-24958-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1478164284-24958-2-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 2d69a3b..5394657 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -75,7 +75,7 @@
 	};
 
 	scpi {
-		compatible = "amlogic,meson-gxbb-scpi";
+		compatible = "amlogic,meson-gxbb-scpi", "arm,legacy-scpi";
 		mboxes = <&mailbox 1 &mailbox 2>;
 		shmem = <&cpu_scp_lpri &cpu_scp_hpri>;
 
-- 
1.9.1
