From: rocky.hao@rock-chips.com (Rocky Hao)
Date: Tue, 25 Jul 2017 17:16:10 +0800
Subject: [PATCH 5/5] arm64: dts: rockchip: Enable tsadc module on RK3328
 eavluation board
In-Reply-To: <1500973788-14627-1-git-send-email-rocky.hao@rock-chips.com>
References: <1500973788-14627-1-git-send-email-rocky.hao@rock-chips.com>
Message-ID: <1500974170-23132-1-git-send-email-rocky.hao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable tsadc module on RK3328 eavluation board

Change-Id: Ieb45a02b90dae3fbefe7d2b571b3961412d866ad
Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
---
 arch/arm64/boot/dts/rockchip/rk3328-evb.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
index 8c61d91bf89b..e7db0dc97ce0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3328-evb.dts
@@ -52,6 +52,10 @@
 	};
 };
 
+&tsadc {
+	status = "okay";
+};
+
 &uart2 {
 	status = "okay";
 };
-- 
1.9.1
