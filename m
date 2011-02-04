From: tony@atomide.com (Tony Lindgren)
Date: Fri, 4 Feb 2011 11:59:38 -0800
Subject: linux-next-20100201 - OMAP2+ defconfig broken with CONFIG_DEBUG_LL
In-Reply-To: <7f99b6fa52967d67bf45d4e8aa7db1e8@mail.gmail.com>
References: <AANLkTinF+dpKvuRztChBM01MAjgL-foGp_yVq3uC9ghu@mail.gmail.com>
	<4af2a35f6d08ddcb33eb86aa3c784fb5@mail.gmail.com>
	<7f99b6fa52967d67bf45d4e8aa7db1e8@mail.gmail.com>
Message-ID: <20110204195938.GA3322@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110201 01:25]:
> > -----Original Message-----
> > From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> > arm-kernel-bounces at lists.infradead.org] On Behalf Of Anand Gadiyar
> > Sent: Tuesday, February 01, 2011 2:54 PM
> > To: linux-arm-kernel at lists.infradead.org; linux-
> > next at vger.kernel.org; Russell King - ARM Linux
> > Subject: RE: linux-next-20100201 - OMAP2+ defconfig broken with
> > CONFIG_DEBUG_LL
> >
> > Gadiyar, Anand wrote:
> > > Hi all,
> > >
> > > I tried to build linux-next as of 20100201 with
> > > omap2plus_defconfig. In addition
> > > I turned on CONFIG_DEBUG_LL and hit the following error.

Posted a fix for that yesterday. Will upload it into Russell's
patch system for the p2v branch.

Tony
