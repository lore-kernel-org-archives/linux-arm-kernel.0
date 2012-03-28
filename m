From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 28 Mar 2012 10:42:18 +0800
Subject: [PATCH v5 2/8] ASoC: imx: merge sound/soc/imx into sound/soc/fsl
In-Reply-To: <2976261.6mYHfHvpym@laptop>
References: <1331888204-27058-1-git-send-email-shawn.guo@linaro.org>
 <1331888204-27058-3-git-send-email-shawn.guo@linaro.org>
 <2976261.6mYHfHvpym@laptop>
Message-ID: <CAAQ0ZWSPJ-5gAJGEYwbyUzjM_Ho851RAHSTBYKgcMtYNRn6ktQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/3/27 Philippe R?tornaz <philippe.retornaz@epfl.ch>:
> Le vendredi 16 mars 2012 16:56:38 Shawn Guo a ?crit :
>> Freescale PowerPC and ARM/IMX families share the same SSI IP block.
>> The patch merges sound/soc/imx into sound/soc/fsl, so that the possible
>> code sharing and consolidation can happen.
>>
>> This is a plain merge, except that menuconfig SND_POWERPC_SOC is added
>> in Kconfig for PowerPC platform as a correspondence to SND_IMX_SOC for
>> IMX platform.
>>
>> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
>> Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
>
> This patch has been merged ? If yes in which tree is it available ?
>
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.5

Regards,
Shawn
