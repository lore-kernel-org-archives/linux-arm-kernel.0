From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Fri,  9 Jun 2017 08:22:15 +0200
Subject: [PATCH v11 11/12] sun4i-codec: Add MIC2 Pre-Amplifier.
In-Reply-To: <20170609062216.26807-1-dannym@scratchpost.org>
References: <20170609062216.26807-1-dannym@scratchpost.org>
Message-ID: <20170609062216.26807-12-dannym@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>
---
 sound/soc/sunxi/sun4i-codec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 730f6151..a9e10dce 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -860,6 +860,8 @@ static const struct snd_soc_dapm_widget sun4i_codec_codec_dapm_widgets[] = {
 	/* Mic Pre-Amplifiers */
 	SND_SOC_DAPM_PGA("MIC1 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
 			 SUN4I_CODEC_ADC_ACTL_PREG1EN, 0, NULL, 0),
+	SND_SOC_DAPM_PGA("MIC2 Pre-Amplifier", SUN4I_CODEC_ADC_ACTL,
+			 SUN4I_CODEC_ADC_ACTL_PREG2EN, 0, NULL, 0),
 
 	/* Power Amplifier */
 	SND_SOC_DAPM_MIXER("Power Amplifier", SUN4I_CODEC_ADC_ACTL,
