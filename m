From: pc.liao@mediatek.com (PC Liao)
Date: Tue, 19 Apr 2016 18:33:04 +0800
Subject: Applied "ASoC: mediatek: Add second I2S on mt8173-rt5650
 machine driver" to the asoc tree
In-Reply-To: <E1asSQc-0004NY-44@debutante>
References: <E1asSQc-0004NY-44@debutante>
Message-ID: <1461061984.28704.8.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 2016-04-19 at 17:58 +0800, Mark Brown wrote:
> The patch
> 
>    ASoC: mediatek: Add second I2S on mt8173-rt5650 machine driver
> 
> has been applied to the asoc tree at
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.  
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark
> 
> From 0beeb8d0b434b8b007ac8058fb2cac5997fff6df Mon Sep 17 00:00:00 2001
> From: PC Liao <pc.liao@mediatek.com>
> Date: Tue, 19 Apr 2016 17:46:12 +0800
> Subject: [PATCH] ASoC: mediatek: Add second I2S on mt8173-rt5650 machine
>  driver
> 
> This patch adds second I2S connection to rt5650 codec for capture path on
> mt8173-rt5650 machine driver.
> 
> This patch depends on [1], because snd_soc_of_get_dai_name() fix the property
> name "sound-dai". This patch needs to change name to use, so export
> snd_soc_get_dai_name() which is included in snd_soc_of_get_dai_name().
> 
> [1] https://patchwork.kernel.org/patch/5671961/ ("ASoC: core: export
> snd_soc_get_dai_name")
> 
> Signed-off-by: PC Liao <pc.liao@mediatek.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Thanks for your approval.
But this patch depends on [1].
I think it also needs to apply [1], otherwise this patch will build
fail.
Or, do I need to upload new version again?
Thanks!  

[1] https://patchwork.kernel.org/patch/5671961/ ("ASoC: core: export
snd_soc_get_dai_name")
