From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 2 Jun 2014 14:14:31 +0800
Subject: [PATCH 1/3] ARM: i.MX: avic: Use irqchip_init() for IRQ
 initialization in DT case
In-Reply-To: <1401685767.327233831@f84.i.mail.ru>
References: <1401516095-31020-1-git-send-email-shc_work@mail.ru>
 <20140602022120.GL8860@dragon> <1401685767.327233831@f84.i.mail.ru>
Message-ID: <20140602061425.GN8860@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 02, 2014 at 09:09:27AM +0400, Alexander Shiyan wrote:
> Mon, 2 Jun 2014 10:21:21 +0800 ?? Shawn Guo <shawn.guo@freescale.com>:
> > On Sat, May 31, 2014 at 10:01:30AM +0400, Alexander Shiyan wrote:
> > > Use generic irqchip_init() DT call to initialize IRQs, so after this patch,
> > > the mxc-avic driver is quite prepared to move to drivers/irqchip.
> ...
> 
> > The patch number in the subject is confusing.  There are 6 patches in
> > the series rather than 3.
> 
> This is a separate series of three patches for AVIC and similar series for TZIC.
> You want me to combine them into one?

As all other 5 patches are in reply to the first one [1], I thought they
are just one series.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/330129
