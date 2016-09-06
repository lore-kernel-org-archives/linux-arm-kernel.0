From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Sep 2016 11:29:52 +0800
Subject: [PATCH] ASoC: sun4i-codec: Distinguish sun4i from sun7i
In-Reply-To: <20160905192404.13871-2-dannym@scratchpost.org>
References: <20160905192404.13871-1-dannym@scratchpost.org>
 <20160905192404.13871-2-dannym@scratchpost.org>
Message-ID: <CAGb2v67yFx1VxGFWQk-Z9V=BQN0kfj1YJWfqb5RCNRUwVWrjbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 6, 2016 at 3:24 AM, Danny Milosavljevic
<dannym@scratchpost.org> wrote:
> ASoC: sun4i-codec: Distinguish sun4i from sun7i
>
> Introduce mechanism to detect sun7i and provide a different regmap, codec
> and different controls for it - different compared to sun4i Allwinner A10.
>
> The controls will be extended in a forthcoming patch - it is necessary to
> distinguish between sun4i and sun7i controls because the mic gains are in
> different registers.
>
> Renamed SUN4I_CODEC_AC_SYS_VERI to SUN7I_CODEC_AC_DAC_CAL and renamed
> SUN4I_CODEC_AC_MIC_PHONE_CAL to SUN7I_CODEC_AC_MIC_PHONE_CAL because these
> are actually not present on Allwinner A10.
>
> Handle quirks by regmap config and codec and select the correct quirks
> automatically.
>
> Signed-off-by: Danny Milosavljevic <dannym@scratchpost.org>

Acked-by: Chen-Yu Tsai <wens@csie.org>
