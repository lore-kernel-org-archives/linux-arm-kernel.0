From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Wed, 1 Feb 2012 06:53:30 +0000
Subject: [PATCH-V5 0/3] Introducing TI's New SoC/board AM335XEVM
In-Reply-To: <20111208171854.GB31337@atomide.com>
References: <hvaibhav@ti.com>
 <1322808204-12878-1-git-send-email-hvaibhav@ti.com> <87y5up44bf.fsf@ti.com>
 <20111207211029.GL31337@atomide.com>
 <79CD15C6BA57404B839C016229A409A8050F6D@DBDE01.ent.ti.com>
 <20111208171854.GB31337@atomide.com>
Message-ID: <79CD15C6BA57404B839C016229A409A8317BB191@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2011 at 22:48:54, Tony Lindgren wrote:
> Russell,
> 
> * Hiremath, Vaibhav <hvaibhav@ti.com> [111208 05:14]:
> > > From: Tony Lindgren [mailto:tony at atomide.com]
> > > * Kevin Hilman <khilman@ti.com> [111206 15:52]:
> > > >
> > > > I've also tested it on a BeagleBone, so feel free to also add:
> > > >
> > > > Tested-by: Kevin Hilman <khilman@ti.com>
> > > 
> > > Thanks looks good to me. We still need the machine_id update to
> > > apply patches 2 and 3 in this series, so applying only the first
> > > patch into soc branch for now.
> > 
> > Tony,
> > 
> > Should I ping Russell for this? The machine-id patch is already registered
> > and present at
> > 
> > http://www.arm.linux.org.uk/developer/machines/download.php
> 
> Care to push the machine_id updates into devel-stable?
> 
Tony,

Can you merge patches 2 & 3 from this series,
as mach-id for AM335xEVM is already available in Mainline
(linus/master or linux-omap/master)?

Thanks,
Vaibhav

> Regards,
> 
> Tony
> 
