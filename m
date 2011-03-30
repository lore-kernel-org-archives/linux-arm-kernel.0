From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 31 Mar 2011 00:25:09 +0200 (CEST)
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <20110330215434.GI18334@atomide.com>
References: <20110317183048.GW7258@atomide.com>
	<AANLkTimWbb5DWiiCW821H6pRicbk1fS3PYcnGyUMznvM@mail.gmail.com>
	<20110318101512.GA15375@n2100.arm.linux.org.uk>
	<201103301906.42429.arnd@arndb.de>
	<AANLkTim578-kwM14SJd06RW_QiC4WVCmFuG+ASgGC4sq@mail.gmail.com>
	<alpine.LFD.2.00.1103302155270.22418@localhost6.localdomain6>
	<20110330215434.GI18334@atomide.com>
Message-ID: <alpine.LFD.2.00.1103310018540.22418@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 30 Mar 2011, Tony Lindgren wrote:

> * Thomas Gleixner <tglx@linutronix.de> [110330 14:07]:
> > 
> > So one person will be not enough, that needs to be a whole team of
> > experienced people in the very near future to deal with the massive
> > tsunami of crap which is targeted at mainline. If we fail to set that
> > up, then we run into a very ugly maintainability issue in no time.
> 
> One thing that will help here and distribute the load is to move
> more things under drivers/ as then we have more maintainers looking
> at the code.

Guess what's that going to solve? Nothing, nada.

Really, you move the problem to people who are not prepared to deal
with the wave either. So what's the gain?

FYI, lots of the wreckage I observed regarding irq stuff was in
drivers/*

My statement stays the same. In whatever playground you try to shift
that problem in it's not going to scale the way it is right now,

Thanks,

	tglx
