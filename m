From: madhu.cr@ti.com (Madhusudhan)
Date: Wed, 24 Mar 2010 10:32:22 -0500
Subject: mmc errors (was Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3)
References: <20100322212025.GW11448@atomide.com>
	<E0D41E29EB0DAC4E9F3FF173962E9E94026F127117@dbde02.ent.ti.com>
	<20100323152709.GD11448@atomide.com> <4BA94564.8030803@ti.com>
Message-ID: <000101cacb67$32973200$544ff780@am.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> -----Original Message-----
> From: Madhusudhan [mailto:madhu.cr at ti.com]
> Sent: Wednesday, March 24, 2010 10:31 AM
> To: 'Nishanth Menon'; 'Tony Lindgren'
> Cc: 'Pais, Allen'; 'linux-arm-kernel at lists.infradead.org'; 'linux-
> omap at vger.kernel.org'; 'Pandita, Vikram'
> Subject: RE: mmc errors (was Re: [PATCH] arm: Fix DEBUG_LL for omap
> zoom2/3)
> 
> Hi Nishant,
> 
> The eMMC on Zoom2 has an issue with respect to detection as a high
> capacity card. This was discussed on the list with Pierre sometime back. I
> don't have an acceptable solution to make this device work. Rather I
> prefer to submit a patch which disables MMC2 on these boards.
> 
> You can still use MMC1 to mount your file system. This is the card you can
> plug in to the cage.
> 
> Regards,
> Madhu
> 
> > -----Original Message-----
> > From: Nishanth Menon [mailto:nm at ti.com]
> > Sent: Tuesday, March 23, 2010 5:49 PM
> > To: Tony Lindgren
> > Cc: Pais, Allen; linux-arm-kernel at lists.infradead.org; linux-
> > omap at vger.kernel.org; Pandita, Vikram; Madhusudhan Chikkature Rajashekar
> > Subject: mmc errors (was Re: [PATCH] arm: Fix DEBUG_LL for omap zoom2/3)
> >
> > Tony Lindgren had written, on 03/23/2010 10:27 AM, the following:
> > [...]
> > > Then at least one issue remains for zoom3 to be usable..
> > > I'm getting tons of MMC errors trying to mount root on it:
> > >
> > > mmcblk1: error -110 transferring data, sector 2097024, nr 8, card
> status
> > 0x900
> > > end_request: I/O error, dev mmcblk1, sector 2097024
> > > ...
> > >
> > I have seen this on few platforms and seem to be related to eMMC usage.
> >
> > > Any ideas if that's fixed somewhere also?
> > Madhu, any comments?
> >
> > --
> > Regards,
> > Nishanth Menon
