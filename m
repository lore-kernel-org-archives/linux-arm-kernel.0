From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 17 Aug 2017 12:44:12 +0800
Subject: [PATCH v3 4/9] arm64: dts: rockchip: Add rt5514 dsp for Gru
In-Reply-To: <20170817044417.22069-1-jeffy.chen@rock-chips.com>
References: <20170817044417.22069-1-jeffy.chen@rock-chips.com>
Message-ID: <20170817044417.22069-5-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add rt5514 dsp of_node to codec list for Gru boards.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index d48e98b62d09..2713129722a1 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -514,7 +514,8 @@
 	sound {
 		compatible = "rockchip,rk3399-gru-sound";
 		rockchip,cpu = <&i2s0 &i2s2>;
-		rockchip,codec = <&max98357a &headsetcodec &codec>;
+		rockchip,codec = <&max98357a &headsetcodec
+				  &codec &wacky_spi_audio>;
 	};
 };
 
-- 
2.11.0
