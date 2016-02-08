From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Mon,  8 Feb 2016 03:17:37 +0100
Subject: [PATCH v2 08/10] ARM64: dts: rockchip: Add tsadc for GeekBox
In-Reply-To: <1454897859-7601-1-git-send-email-afaerber@suse.de>
References: <1454897859-7601-1-git-send-email-afaerber@suse.de>
Message-ID: <1454897859-7601-9-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
index fe5aa785cfda..7e518768f8b0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3368-geekbox.dts
@@ -298,6 +298,12 @@
 	};
 };
 
+&tsadc {
+	status = "okay";
+	rockchip,hw-tshut-mode = <0>; /* CRU */
+	rockchip,hw-tshut-polarity = <0>; /* low */
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
2.6.2
