From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Sun, 22 Jul 2018 23:56:16 +0000
Subject: [PATCH] ASoC: wm9712: fix replace codec to component
In-Reply-To: <1532078447.19673.8.camel@ziswiler.com>
References: <20180720075148.14648-1-marcel@ziswiler.com>
 <87effy48lz.wl-kuninori.morimoto.gx@renesas.com>
 <1532078447.19673.8.camel@ziswiler.com>
Message-ID: <87d0ve7ru7.wl-kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Marcel

> > > Since commit 143b44845d87 ("ASoC: wm9712: replace codec to
> > > component")
> > > "wm9712-codec" got renamed to "wm9712-component", however, this
> > > change
> > > never got propagated down to the actual board/platform drivers.
> > > E.g. on
> > > Colibri T20 this lead to the following spew upon boot with
> > > sound/touch
> > > being broken:
> > 
> > Oops, my bad...
> > The platform_driver name is not important,
> > how about simply rename back it to "wm9712-codec" ?
> 
> Sure, that's your call. After all it was now broken for almost half a
> year (;-p). Should I cook that up as well or are you gona do it?

Sorry about that.
I can't test it, you can do it ?

Best regards
---
Kuninori Morimoto
