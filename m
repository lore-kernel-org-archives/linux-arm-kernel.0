From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 18 Mar 2015 10:52:16 +0100
Subject: [PATCH v6 01/12] ARM: tegra: Change model of sound card in Nyan Big
In-Reply-To: <1426672363-30667-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1426672363-30667-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1426672363-30667-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change it from "Acer Chromebook 13" to GoogleNyanBig so it's unique and
identifiable.

With this change the card id exposed to userspace becomes GoogleNyanBig
instead of the current A13.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/boot/dts/tegra124-nyan-big.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts b/arch/arm/boot/dts/tegra124-nyan-big.dts
index 004e8e4..e167df2 100644
--- a/arch/arm/boot/dts/tegra124-nyan-big.dts
+++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
@@ -1110,7 +1110,7 @@
 	sound {
 		compatible = "nvidia,tegra-audio-max98090-nyan-big",
 			     "nvidia,tegra-audio-max98090";
-		nvidia,model = "Acer Chromebook 13";
+		nvidia,model = "GoogleNyanBig";
 
 		nvidia,audio-routing =
 			"Headphones", "HPR",
-- 
2.1.0
