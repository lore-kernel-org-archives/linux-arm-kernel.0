From: kuninori.morimoto.gx@gmail.com (Kuninori Morimoto)
Date: Mon, 01 Sep 2014 00:50:19 -0700 (PDT)
Subject: [alsa-devel] [PATCHv1 1/7] ASoC: simple-card: Merge single and
 muti	DAI link code.
In-Reply-To: <ac4db632b6c944dcb2179089076b7871@BY2PR0301MB0613.namprd03.prod.outlook.com>
References: <1409545781-20530-1-git-send-email-Li.Xiubo@freescale.com>
 <1409545781-20530-2-git-send-email-Li.Xiubo@freescale.com>
 <87tx4rzszx.wl%kuninori.morimoto.gx@gmail.com>
 <ac4db632b6c944dcb2179089076b7871@BY2PR0301MB0613.namprd03.prod.outlook.com>
Message-ID: <87sikbzsne.wl%kuninori.morimoto.gx@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Xiubo

> > These are using
> > 
> >       asoc_simple_card_sub_parse_of(np, &dai_props->cpu_dai, xxx)
> >       asoc_simple_card_sub_parse_of(np, &dai_props->codec_dai, xxx)
> > 
> > I guess, asoc_simple_card_sub_parse_of() can update
> > below inside function
> > 
> > 	dai_props->cpu_dai.fmt |= daifmt;
> > 	dai_props->codec_dai.fmt |= daifmt;
> > 
> > 
> 
> Yes, yes, that's very well.
> 
> Thanks very much for you advice.
> 
> For some reason I must resent this patch series, and then I will
> fix this together.

Thank you for your help

Best regards
---
Kuninori Morimoto
