From: rocky.hao@rock-chips.com (Rocky Hao)
Date: Fri,  4 Aug 2017 16:09:40 +0800
Subject: [PATCH v2 5/5] arm64: dts: rockchip: Enable tsadc module on RK3328
 eavluation board
In-Reply-To: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
References: <1501833976-1100-1-git-send-email-rocky.hao@rock-chips.com>
Message-ID: <1501834180-1830-1-git-send-email-rocky.hao@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

enable tsadc module on RK3328 eavluation board

Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
---
Change in v2:
- remove gerrit Change-Id

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
