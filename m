From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Jan 2015 16:05:12 +0100
Subject: [PATCH v4 2/6] mfd: MT6397: Add support for PMIC MT6397 MFD
In-Reply-To: <20150120144309.GT13701@x1>
References: <1419577768-12037-1-git-send-email-flora.fu@mediatek.com>
 <1419577768-12037-3-git-send-email-flora.fu@mediatek.com>
 <20150120144309.GT13701@x1>
Message-ID: <20150120150512.GA12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Jan 20, 2015 at 02:43:09PM +0000, Lee Jones wrote:
> On Fri, 26 Dec 2014, Flora Fu wrote:
> 
> > Add core files for MT6397 MFD driver.
> > 
> > Signed-off-by: Flora Fu <flora.fu@mediatek.com>
> > ---
> >  drivers/mfd/Kconfig                  |  10 +
> >  drivers/mfd/Makefile                 |   1 +
> >  drivers/mfd/mt6397-core.c            |  94 +++++++++
> >  include/linux/mfd/mt6397/core.h      |  23 +++
> >  include/linux/mfd/mt6397/registers.h | 362 +++++++++++++++++++++++++++++++++++
> >  5 files changed, 490 insertions(+)
> >  create mode 100644 drivers/mfd/mt6397-core.c
> >  create mode 100644 include/linux/mfd/mt6397/core.h
> >  create mode 100644 include/linux/mfd/mt6397/registers.h
> 
> Looks okay.
> 
> I assume there are dependancies on this patch.  What are they?
> 
> How would you like this set to be handled?

This patch is outdated, I sent an updated series today (you are on Cc).

There are no compile time dependencies to the PMIC wrapper, but without
it the mfd part is pretty useless. I prefer to keep the series together
and merge it through arm-soc, but I would be fine with merging it
through mfd aswell.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
