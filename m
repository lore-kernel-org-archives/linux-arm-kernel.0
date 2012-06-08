From: zhangfei.gao@gmail.com (zhangfei gao)
Date: Fri, 8 Jun 2012 21:24:19 +0800
Subject: [alsa-devel] [PATCH v1 4/5] ASoC: add mmp brownstone support
In-Reply-To: <20120607221325.GB14525@opensource.wolfsonmicro.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
 <1338791851-21038-5-git-send-email-zhangfei.gao@marvell.com>
 <20120607221325.GB14525@opensource.wolfsonmicro.com>
Message-ID: <CAMj5BkhB+ifYpV5Cv0w_sp-eGdmBhbtJdmdGPfpZygyHfzQBAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 8, 2012 at 6:13 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 04, 2012 at 02:37:30PM +0800, Zhangfei Gao wrote:
>
> One small thing here...
>
>> + ? ? ret = snd_soc_add_card_controls(dapm->card, brownstone_dapm_control,
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?ARRAY_SIZE(brownstone_dapm_control));
>> + ? ? if (ret < 0)
>> + ? ? ? ? ? ? return ret;
>
> You can just set these up with the controls member of the card struct.

Great, it will make it easier, thanks.

>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel at alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
