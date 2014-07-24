From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 24 Jul 2014 16:49:46 +0800
Subject: [PATCH 2/3] ARM: smp_scu: enable SCU standby support
In-Reply-To: <20140723164521.GF20966@arm.com>
References: <1405928755-19413-1-git-send-email-shawn.guo@freescale.com>
 <1405928755-19413-3-git-send-email-shawn.guo@freescale.com>
 <20140721085150.GB15666@arm.com> <20140721092703.GL8537@dragon>
 <20140721102638.GE32578@arm.com> <20140722020911.GO8537@dragon>
 <20140722161331.GN2219@arm.com> <20140723045055.GA5615@dragon>
 <20140723164521.GF20966@arm.com>
Message-ID: <20140724084945.GB8821@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 23, 2014 at 05:45:21PM +0100, Catalin Marinas wrote:
> On Wed, Jul 23, 2014 at 05:50:57AM +0100, Shawn Guo wrote:
> > On Tue, Jul 22, 2014 at 05:13:31PM +0100, Catalin Marinas wrote:
> > > And we don't know the behaviour of setting this bit on such A9 early
> > > revisions. So we can try to (1) find out if there are any in the field,
> > > (2) read the RTL to see if anything happens or (3) add a check in Linux
> > > for such revisions. I think (3) should be the case but you need to figure
> > > out which revisions these are.
> > 
> > Can I ask the favor from you ARM folks on that, since I cannot figure
> > it out from any public information?
> 
> Looking through some of the older A9 TRMs, it seems that this bit was
> added in r2p0. Whether it works as advertised on the relevant SoCs I
> can't tell.

Thanks for checking, Catalin.

Shawn
