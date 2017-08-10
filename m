From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Thu, 10 Aug 2017 12:54:57 +0800
Subject: [PATCH v2 2/3] arm64: dts: rockchip: Add rockchip,
 codec-names property
In-Reply-To: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com>
References: <1502340898-28403-1-git-send-email-jeffy.chen@rock-chips.com>
Message-ID: <1502340898-28403-3-git-send-email-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add rockchip,codec-names property for codecs.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
index d48e98b..c8f7f0c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
@@ -515,6 +515,7 @@
 		compatible = "rockchip,rk3399-gru-sound";
 		rockchip,cpu = <&i2s0 &i2s2>;
 		rockchip,codec = <&max98357a &headsetcodec &codec>;
+		rockchip,codec-names = "MAX98357A", "RT5514", "DA7219";
 	};
 };
 
-- 
2.1.4
