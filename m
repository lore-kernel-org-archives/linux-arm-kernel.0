From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Wed, 25 Nov 2015 23:54:06 +0000
Subject: [PATCH] ASoC: rcar: remove unused variable
In-Reply-To: <4083363.2bJPz8BMy4@wuerfel>
References: <4929159.b95vLdVRYU@wuerfel>
 <878u5m8ut0.wl%kuninori.morimoto.gx@renesas.com>
 <4083363.2bJPz8BMy4@wuerfel>
Message-ID: <87ziy1d4j8.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Mark, Arnd

> > /opt/home/morimoto/WORK/linux/sound/soc/sh/rcar/core.c: In function '__rsnd_kctrl_new':
> > /opt/home/morimoto/WORK/linux/sound/soc/sh/rcar/core.c:807:18: error: 'soc_card' undeclared (first use in this function)
> >    .index  = rtd - soc_card->rtd,
> >                   ^
> > /opt/home/morimoto/WORK/linux/sound/soc/sh/rcar/core.c:807:18: note: each undeclared identifier is reported only once for each function it appears in
> > make[6]: *** [sound/soc/sh/rcar/core.o] ??? 1
> > make[6]: *** ??????????????....
> > make[5]: *** [sound/soc/sh/rcar] ??? 2
> > make[4]: *** [sound/soc/sh] ??? 2
> > 
> > This __rsnd_kctrl_new() is using "soc_card"...
> 
> It looks like the commit that removed the user of that variable is in the
> "topic/pcm-list" branch instead of "topic/rcar".

Mark

It is possible to remove this patch from topic/rcar,
and, apply it to topic/pcm-list ?

ccae40fa973f5b0eec5d5ad27e81c5a2b95f7b7c
(" ASoC: rcar: remove unused variable")
