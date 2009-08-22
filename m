From: marek.vasut@gmail.com (Marek Vasut)
Date: Sat, 22 Aug 2009 11:24:57 +0200
Subject: [PATCH] Convert MMC subsys drivers to dev_pm_ops
In-Reply-To: <20090822082559.GA6562@console-pimps.org>
References: <200908220223.50588.marek.vasut@gmail.com>
	<20090822082559.GA6562@console-pimps.org>
Message-ID: <200908221124.57585.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne So 22. srpna 2009 10:27:37 Matt Fleming napsal(a):
> (Adding linux-mmc at vger.kernel.org to the CC list)
>
> On Sat, Aug 22, 2009 at 02:23:50AM +0200, Marek Vasut wrote:
> > Hi,
> >
> > This converts most of the drivers found in drivers/mmc/host to
> > dev_pm_ops. Also, it contains some fixes for the probe/remove functions
> > in some cases.
> >
> > This needs testing, so I'd be very glad if the affected maintainers
> > expressed their opinion on this.
> >
> > Cheers!
> >
> > From 66978eef1d2bd64222901f0b6c6d9c35dcca044e Mon Sep 17 00:00:00 2001
> > From: Marek Vasut <marek.vasut@gmail.com>
> > Date: Sat, 22 Aug 2009 02:10:27 +0200
> > Subject: [PATCH] Convert MMC subsys drivers to dev_pm_ops
> >
> > This converts most of the drivers found in drivers/mmc/host to
> > dev_pm_ops. Also, it contains some fixes for the probe/remove functions
> > in some cases.
Hi.

it might be actually better if you fixed your platforms and submitted the 
patches independently as it seems you have better understanding of the 
hardware you maintain ;-)

Cheers!
