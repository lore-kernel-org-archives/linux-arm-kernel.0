From: zumeng.chen@gmail.com (Zumeng Chen)
Date: Thu, 14 Jun 2012 11:29:45 +0800
Subject: [PATCH 5/5] Input: ads7846: set proper debounce time in driver
 level
In-Reply-To: <20120613125543.GU12766@atomide.com>
References: <zumeng.chen@gmail.com>
 <1339423216-1323-1-git-send-email-zumeng.chen@gmail.com>
 <1339423216-1323-6-git-send-email-zumeng.chen@gmail.com>
 <20120612064757.GE12766@atomide.com>
 <CA+Y31wdGaMDrT6ySE1y2Z5sw5ah8fE7im_=BvH=s+U+P619O=g@mail.gmail.com>
 <20120613125543.GU12766@atomide.com>
Message-ID: <CA+Y31weR6dFSn9zWZrS1On+Ngq0zzfLS=OUpdmhUteuXpHpSmw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/6/13 Tony Lindgren <tony@atomide.com>

> * Zumeng Chen <zumeng.chen@gmail.com> [120612 09:41]:
> > 2012/6/12 Tony Lindgren <tony@atomide.com>
> >
> > > * Zumeng Chen <zumeng.chen@gmail.com> [120611 07:05]:
> > > > If we don't set proper debouce time for ads7846, then there are
> > > > flooded interrupt counters of ads7846 responding to one time
> > > > touch on screen, so the driver couldn't work well.
> > > >
> > > > And since most OMAP3 series boards pass NULL pointer of board_pdata
> > > > to omap_ads7846_init, so it's more proper to set it in driver level
> > > > after having gpio_request done.
> > > >
> > > > This patch has been validated on 3530evm.
> > > >
> > > > Signed-off-by: Zumeng Chen <zumeng.chen@gmail.com>
> > > > Signed-off-by: Syed Mohammed Khasim <khasim@ti.com>
> > > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > >
> > > Please remove my Signed-off-by, where does that come from?
> > >
> > HI Tony,
> >
> > This comes from git://arago-project.org/git/projects/linux-omap3.git
> > The commit ID is 53c5ec31, we set gpio_debounce in arch/board
> > level.
>
> Weird, I have no recollection of doing anything with that file..
> Just remove my Signed-off-by please.
>
NP, Tony, done on V2.

Regards,
Zumeng

>
> Tony
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120614/7cb3dde7/attachment-0001.html>
