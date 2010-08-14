From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Sat, 14 Aug 2010 11:47:27 +0100
Subject: [alsa-devel] [PATCH 2/5] ASoC: fix pxa2xx-pcm.h path
In-Reply-To: <1281713056.2074.28.camel@Tapajos>
References: <AANLkTi=_BX_z68p3SGhr08K5JOmudaNRvZMVUAvSGfZV@mail.gmail.com>
	<1281713056.2074.28.camel@Tapajos>
Message-ID: <1281782847.3394.121.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2010-08-13 at 16:24 +0100, Ian Lartey wrote:
> On Fri, 2010-08-13 at 21:55 +0800, Haojian Zhuang wrote:
> > From b761e3bb374e630011f22ce54963877310a0baca Mon Sep 17 00:00:00 2001
> > From: Haojian Zhuang <haojian.zhuang@marvell.com>
> > Date: Fri, 13 Aug 2010 21:14:52 +0800
> > Subject: [PATCH 2/5] ASoC: fix pxa2xx-pcm.h path
> > 
> > Since pxa2xx-pcm.h is removed from sound/soc/pxa, we need to update the
> > path in related files.
> > 
> > Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
> > ---
> >  sound/soc/pxa/pxa-ssp.c    |    2 +-
> >  sound/soc/pxa/pxa2xx-pcm.c |    1 -
> >  2 files changed, 1 insertions(+), 2 deletions(-)
> 
> Tested-by: Ian Lartey <ian@opensource.wolfsonmicro.com>
> 

Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
