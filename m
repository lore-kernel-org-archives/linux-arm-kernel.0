From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 28 Jan 2015 11:50:59 +0100
Subject: [PATCH v3 01/10] ARM: tegra: Set the sound card model that alsaucm
 expects
In-Reply-To: <1422442278-10405-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1422442278-10405-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1422442278-10405-2-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patches are on its way to add a config file to alsaucm for the Nyan
boards. Use the same card ID that alsaucm will expect.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 arch/arm/boot/dts/tegra124-nyan-big.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-nyan-big.dts b/arch/arm/boot/dts/tegra124-nyan-big.dts
index 004e8e4..eda6ae7 100644
--- a/arch/arm/boot/dts/tegra124-nyan-big.dts
+++ b/arch/arm/boot/dts/tegra124-nyan-big.dts
@@ -1108,9 +1108,9 @@
 	};
 
 	sound {
-		compatible = "nvidia,tegra-audio-max98090-nyan-big",
+		compatible = "nvidia,tegra-audio-max98090-nyan",
 			     "nvidia,tegra-audio-max98090";
-		nvidia,model = "Acer Chromebook 13";
+		nvidia,model = "GoogleNyan";
 
 		nvidia,audio-routing =
 			"Headphones", "HPR",
-- 
1.9.3
