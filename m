From: moinejf@free.fr (Jean-Francois Moine)
Date: Tue, 16 Aug 2016 15:01:04 +0200
Subject: [PATCH v2] regulator: axp20x: support AXP803/AXP813 variants
In-Reply-To: <248521471347017@web1g.yandex.ru>
References: <E1bZY0w-0004lM-0a@bombadil.infradead.org>
 <248521471347017@web1g.yandex.ru>
Message-ID: <20160816150104.16a7bcf774135c8275828eda@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Aug 2016 19:30:17 +0800
Icenowy Zheng <icenowy@aosc.xyz> wrote:

> > The X-Powers AXP803 and AXP813 PMICs are close to the AXP809 with some
> > more outputs.
> AXP803 and AXP813 is quite different.
> AXP803 have 6 DCDCs and 16 LDOs&Switch.
> AXP813 have 7 DCDCs and 15 LDOs&Switch.
> and AXP813 have an audio codec.
> 
> AXP803 cannot be handled without extra code.
> 
> (I'm trying to get RSB working in my semi-mainline A64 kernel)

Hi Icenowy,

Interesting.
I did not find the documentation about the AXP813, but looking at the
Banana PI M3 driver (which seems a bit buggy), I found it was very
close to the AXP803.

Which more code do you think is needed for the AXP803?

Also, please, may you give me a pointer to the AXP813 documentation?

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
