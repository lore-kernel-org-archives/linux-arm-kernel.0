From: sjoerd.simons@collabora.co.uk (Sjoerd Simons)
Date: Mon,  5 Oct 2015 21:03:39 +0200
Subject: [PATCH] ASoC: rockchip: namespace rockchip i2s module name
Message-ID: <1444071819-11521-1-git-send-email-sjoerd.simons@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the rockchip i2s object name (and thus module name) from the
rather generic snd-soc-i2s to the more specific snd-soc-rockchip-i2s

Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>

---

 sound/soc/rockchip/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/Makefile b/sound/soc/rockchip/Makefile
index 1bc1dc3..e9ba558 100644
--- a/sound/soc/rockchip/Makefile
+++ b/sound/soc/rockchip/Makefile
@@ -1,7 +1,7 @@
 # ROCKCHIP Platform Support
-snd-soc-i2s-objs := rockchip_i2s.o
+snd-soc-rockchip-i2s-objs := rockchip_i2s.o
 
-obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-i2s.o
+obj-$(CONFIG_SND_SOC_ROCKCHIP_I2S) += snd-soc-rockchip-i2s.o
 
 snd-soc-rockchip-max98090-objs := rockchip_max98090.o
 snd-soc-rockchip-rt5645-objs := rockchip_rt5645.o
-- 
2.6.0
