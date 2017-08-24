From: rocky.hao@rock-chips.com (Rocky Hao)
Date: Thu, 24 Aug 2017 18:32:14 +0800
Subject: [PATCH 5/5] arm: dts: rockchip: enable tsadc module on RV1108
 evaluation board
In-Reply-To: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
Message-ID: <1503570734-8942-1-git-send-email-rocky.hao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable tsadc module on RV1108 evaluation board

Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
---
 arch/arm/boot/dts/rv1108-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/rv1108-evb.dts b/arch/arm/boot/dts/rv1108-evb.dts
index 39197c3e9e0e..885f760d8ca1 100644
--- a/arch/arm/boot/dts/rv1108-evb.dts
+++ b/arch/arm/boot/dts/rv1108-evb.dts
@@ -218,6 +218,10 @@
 	status = "okay";
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &uart0 {
 	status = "okay";
 };
-- 
1.9.1
