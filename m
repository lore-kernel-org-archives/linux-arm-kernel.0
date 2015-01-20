From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Jan 2015 14:27:51 +0100
Subject: [PATCH 2/8] soc: Add MediaTek pericfg controller support
In-Reply-To: <1421759910.11671.69.camel@mtksdaap41>
References: <1421747231-554-1-git-send-email-s.hauer@pengutronix.de>
 <1421747231-554-3-git-send-email-s.hauer@pengutronix.de>
 <1421759910.11671.69.camel@mtksdaap41>
Message-ID: <20150120132751.GM18220@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joe,

On Tue, Jan 20, 2015 at 09:18:30PM +0800, Yingjoe Chen wrote:
> On Tue, 2015-01-20 at 10:47 +0100, Sascha Hauer wrote:
> <...>
> > diff --git a/drivers/soc/mediatek/mtk-pericfg.c b/drivers/soc/mediatek/mtk-pericfg.c
> > index b7ee902..aa9a7eb 100644
> > --- a/drivers/soc/mediatek/mtk-pericfg.c
> > +++ b/drivers/soc/mediatek/mtk-pericfg.c
> > @@ -1,6 +1,5 @@
> >  /*
> >   * Copyright (c) 2014 MediaTek Inc.
> > - * Author: Flora Fu <flora.fu@mediatek.com>
> >   *
> >   * This program is free software; you can redistribute it and/or modify
> >   * it under the terms of the GNU General Public License version 2 as
> 
> Hi Sascha,
> 
> I believe you want to add mtk-pericfg.c here instead of adding it in
> first patch and only change author here.

Indeed. Fixed for the next round.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
