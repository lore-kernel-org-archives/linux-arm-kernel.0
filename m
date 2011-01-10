From: Trond.Myklebust@netapp.com (Trond Myklebust)
Date: Mon, 10 Jan 2011 15:15:07 -0500
Subject: still nfs problems [Was: Linux 2.6.37-rc8]
In-Reply-To: <AANLkTinFenq3BEiUQRsxDy6EKwqSM33RcwFG4fs-sXLJ@mail.gmail.com>
References: <AANLkTimusF4KCJ4vHPn+T1dUiKxapXaT0QTtFvh8Ykdd@mail.gmail.com>
	<1294426405.2929.23.camel@heimdal.trondhjem.org>
	<20110107190229.GX31708@n2100.arm.linux.org.uk>
	<1294427467.4895.66.camel@mulgrave.site>
	<1294505384.4181.14.camel@heimdal.trondhjem.org>
	<1294528551.4181.19.camel@heimdal.trondhjem.org>
	<20110110105019.GC24920@pengutronix.de>
	<1294676734.3349.10.camel@heimdal.trondhjem.org>
	<4D2B3D03.8050504@pengutronix.de>
	<1294680035.3349.19.camel@heimdal.trondhjem.org>
	<20110110192552.GG24920@pengutronix.de>
	<1294687767.3349.28.camel@heimdal.trondhjem.org>
	<AANLkTinFenq3BEiUQRsxDy6EKwqSM33RcwFG4fs-sXLJ@mail.gmail.com>
Message-ID: <1294690507.3349.31.camel@heimdal.trondhjem.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-01-10 at 11:34 -0800, Linus Torvalds wrote: 
> 2011/1/10 Trond Myklebust <Trond.Myklebust@netapp.com>:
> >
> > I usually do this, but there is a slight problem with that approach:
> > Greg gets to do all the work of figuring out to which stable kernels
> > this particular patch applies. In this case, since we're only talking
> > about the 2.6.37 kernel, I prefer to use the mailing lists.
> 
> Just do
> 
>   Cc: stable at kernel.org  [2.6.37]
> 
> or similar. It's quite common.
> 
> So EVEN IF you want to email people around about the patch separately,
> do add the "Cc: stable" marker. It's worthwhile information about the
> patch for everybody involved.

OK. Patch description amended and recommitted in git. Thanks to all for
the tips...

-- 
Trond Myklebust
Linux NFS client maintainer

NetApp
Trond.Myklebust at netapp.com
www.netapp.com
