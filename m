From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Sep 2017 14:46:47 +0100
Subject: Applied "ASoC: rockchip: Add dapm route for DMic" to the asoc tree
In-Reply-To: <20170918014441.17572-2-jeffy.chen@rock-chips.com>
Message-ID: <E1duIrP-0008Ib-8y@debutante>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch

   ASoC: rockchip: Add dapm route for DMic

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From cc9fee8e1a2088e1853a1ba7b9f91d0629da0807 Mon Sep 17 00:00:00 2001
From: Jeffy Chen <jeffy.chen@rock-chips.com>
Date: Mon, 18 Sep 2017 19:18:00 +0800
Subject: [PATCH] ASoC: rockchip: Add dapm route for DMic

Add dapm route for DMIC codec.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 3475c61a5fa0..1ca269ee0b7e 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -54,6 +54,7 @@ static const struct snd_soc_dapm_route rockchip_dapm_routes[] = {
 	{"MIC", NULL, "Headset Mic"},
 	{"DMIC1L", NULL, "Int Mic"},
 	{"DMIC1R", NULL, "Int Mic"},
+	{"DMic", NULL, "Int Mic"},
 
 	/* Output Lines */
 	{"Headphones", NULL, "HPL"},
-- 
2.14.1
