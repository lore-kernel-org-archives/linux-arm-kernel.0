From: jeffy.chen@rock-chips.com (Jeffy Chen)
Date: Mon, 18 Sep 2017 19:18:00 +0800
Subject: [RESEND PATCH v2 2/3] ASoC: rockchip: Add dapm route for DMic
In-Reply-To: <20170918111801.12881-1-jeffy.chen@rock-chips.com>
References: <20170918111801.12881-1-jeffy.chen@rock-chips.com>
Message-ID: <20170918111801.12881-2-jeffy.chen@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add dapm route for DMIC codec.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2: None

 sound/soc/rockchip/rk3399_gru_sound.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index b050510be65f..ad19e391c4a6 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -55,6 +55,7 @@ static const struct snd_soc_dapm_route rockchip_dapm_routes[] = {
 	{"MIC", NULL, "Headset Mic"},
 	{"DMIC1L", NULL, "Int Mic"},
 	{"DMIC1R", NULL, "Int Mic"},
+	{"DMic", NULL, "Int Mic"},
 
 	/* Output Lines */
 	{"Headphones", NULL, "HPL"},
-- 
2.11.0
