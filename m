From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Fri, 20 Jul 2018 08:30:41 +0000
Subject: [PATCH] ASoC: wm9712: fix replace codec to component
In-Reply-To: <20180720075148.14648-1-marcel@ziswiler.com>
References: <20180720075148.14648-1-marcel@ziswiler.com>
Message-ID: <87effy48lz.wl-kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Marcel

> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Since commit 143b44845d87 ("ASoC: wm9712: replace codec to component")
> "wm9712-codec" got renamed to "wm9712-component", however, this change
> never got propagated down to the actual board/platform drivers. E.g. on
> Colibri T20 this lead to the following spew upon boot with sound/touch
> being broken:

Oops, my bad...
The platform_driver name is not important,
how about simply rename back it to "wm9712-codec" ?

Best regards
---
Kuninori Morimoto
