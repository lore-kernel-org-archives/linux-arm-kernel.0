From: fabioestevam@yahoo.com (Fabio Estevam)
Date: Wed, 3 Nov 2010 13:14:14 -0700 (PDT)
Subject: [patch 1/1] imx: fix iomux v3
In-Reply-To: <20101103194018.GC11176@pengutronix.de>
Message-ID: <765778.7804.qm@web51003.mail.re2.yahoo.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Uwe,

--- On Wed, 11/3/10, Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de> wrote:

> From: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Subject: Re: [patch 1/1] imx: fix iomux v3
> To: "Fabio Estevam" <fabioestevam@yahoo.com>
> Cc: s.hauer at pengutronix.de, "Arnaud Patard" <arnaud.patard@rtp-net.org>, linux-arm-kernel at lists.infradead.org, LW at KARO-electronics.de
> Date: Wednesday, November 3, 2010, 5:40 PM
> On Wed, Nov 03, 2010 at 08:25:29AM
> -0700, Fabio Estevam wrote:
> > Arnaud,
> > 
> > --- On Wed, 11/3/10, Arnaud Patard <arnaud.patard@rtp-net.org>
> wrote:
> > 
> > > From: Arnaud Patard <arnaud.patard@rtp-net.org>
> > > Subject: [patch 1/1] imx: fix iomux v3
> > > To: s.hauer at pengutronix.de
> > > Cc: linux-arm-kernel at lists.infradead.org,
> LW at KARO-electronics.de
> > > Date: Wednesday, November 3, 2010, 12:54 PM
> > > Commit "ARM: i.MX IOMUX-V3 replace
> > > struct pad_desc with bitmapped cookie"
> > > (b705cb4d42e95a4a43a8945571c8613e71526c3d)
> introduced a
> > > typo which was
> > > preventing my efikamx to boot. This patch is
> fixing that.
> > 
> > Thanks. When I tried 2.6.37-rc1 today I was not able
> to boot Linux on Babbage. Your patch fixed the problem.
> Hmmm, b705cb4d42e95a4a43a8945571c8613e71526c3d is only in
> Sascha's
> imx-for-2.6.38 branch and Arnaud's patch doesn't apply to
> Linus tree.
> 
> I wonder if that invalidates your tested-by somehow.

Actually I tested it on Sascha?s imx-for-2.6.38 branch.

Thanks,

Fabio Estevam



      
