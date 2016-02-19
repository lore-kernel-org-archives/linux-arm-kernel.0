From: broonie@kernel.org (Mark Brown)
Date: Sat, 20 Feb 2016 00:37:44 +0900
Subject: [PATCH] ASoC: mediatek: Add machine driver for ALC5650 codec
In-Reply-To: <1455849359-14581-1-git-send-email-pc.liao@mediatek.com>
References: <1455849359-14581-1-git-send-email-pc.liao@mediatek.com>
Message-ID: <20160219153744.GP18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 10:35:59AM +0800, PC Liao wrote:

> @@ -3,3 +3,4 @@ obj-$(CONFIG_SND_SOC_MEDIATEK) += mtk-afe-pcm.o
>  # Machine support
>  obj-$(CONFIG_SND_SOC_MT8173_MAX98090) += mt8173-max98090.o
>  obj-$(CONFIG_SND_SOC_MT8173_RT5650_RT5676) += mt8173-rt5650-rt5676.o
> +obj-$(CONFIG_SND_SOC_MT8173_RT5650) += mt8173-rt5650.o

Why is this not covered by (or coverable by) the existinng RT5650-RT5657
driver?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160220/c90df662/attachment.sig>
