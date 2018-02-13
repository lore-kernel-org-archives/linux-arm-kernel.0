From: kuninori.morimoto.gx@renesas.com (Kuninori Morimoto)
Date: Tue, 13 Feb 2018 04:24:29 +0000
Subject: [PATCH v2 0/9] add UniPhier audio system support
In-Reply-To: <20180212124858.GC12976@sirena.org.uk>
References: <20180119092536.22501-1-suzuki.katsuhiro@socionext.com>
 <20180212124858.GC12976@sirena.org.uk>
Message-ID: <87vaf1jz6z.wl%kuninori.morimoto.gx@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Mark

> > This series adds support for Socionext audio system for
> > UniPhier LD11/LD20 SoCs. This driver supports I2S output
> > for Line-In, Line-Out and S/PDIF output.
> 
> These look fine so I'll apply them however a patch series from
> Morimoto-san (CCed) moving things to use components rather than
> CODEC/platform/whatever driver types that was sent about the same time
> has just gone in - the driver will require the same conversions.

Thank you for pointing it.
I posted conversion patch for this driver.

Best regards
---
Kuninori Morimoto
