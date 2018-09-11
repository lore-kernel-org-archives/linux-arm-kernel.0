From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 11 Sep 2018 17:10:47 -0300
Subject: [PATCH 6/6] ARM: dts: vf610-zii-cfu1: Pass the 'no-sd' property
In-Reply-To: <1536696647-8228-1-git-send-email-festevam@gmail.com>
References: <1536696647-8228-1-git-send-email-festevam@gmail.com>
Message-ID: <1536696647-8228-6-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass the 'no-sd' for esdhc0 controller as it is wired to eMMC.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 arch/arm/boot/dts/vf610-zii-cfu1.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/vf610-zii-cfu1.dts b/arch/arm/boot/dts/vf610-zii-cfu1.dts
index aba4cec..b76c3d0 100644
--- a/arch/arm/boot/dts/vf610-zii-cfu1.dts
+++ b/arch/arm/boot/dts/vf610-zii-cfu1.dts
@@ -123,6 +123,7 @@
 	no-1-8-v;
 	keep-power-in-suspend;
 	no-sdio;
+	no-sd;
 	status = "okay";
 };
 
-- 
2.7.4
