From: marek.vasut@gmail.com (Marek Vasut)
Date: Wed, 13 Apr 2011 19:12:17 +0200
Subject: zaurus: mmcblk0: error -110
In-Reply-To: <201104131910.53824.marek.vasut@gmail.com>
References: <20110412151547.GC20815@atrey.karlin.mff.cuni.cz>
	<20110412180414.GA26916@elf.ucw.cz>
	<201104131910.53824.marek.vasut@gmail.com>
Message-ID: <201104131912.17823.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 13, 2011 07:10:53 PM Marek Vasut wrote:
> On Tuesday, April 12, 2011 08:04:14 PM Pavel Machek wrote:
> > On Tue 2011-04-12 17:52:17, Cyril Hrubis wrote:
> > > Hi!
> > > 
> > > > > Which model do you have? And check the corresponding board file if
> > > > > card detect GPIO handling is doing right.
> > > > 
> > > > I've got spitz (SL-3200).
> > > > 
> > > > So I suppose the board file is arch/arm/mach-pxa/spitz.c, I'll have a
> > > > look.
> > > 
> > > Hmm, besides cleanup by Marek Vasut there were no changes in the code.
> > > And it seems that it was just cleanup in spitz_card_pwr_ctrl().
> > 
> > With vanilla 2.6.38, I observe similar problem. MMC removal is not
> > detected; I get "error -110 whilst initalising SD card" on reinsert.
> > 
> > 									Pavel
> 
> I don't observe this problem with my tree (.38-rc8+). I'll have to check
> properly though. (On SL-C1000)
> 
> Cyril, can you bisect between .37 and .38? I suspect some change in mmc
> subsys.
> 
> Cheers

I see it was solved, ignore this ;-)
