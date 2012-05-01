From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 1 May 2012 12:39:36 +0000
Subject: [GIT PULL] ARM: spear-soc clock updates for 3.5
In-Reply-To: <20120501114743.GD2194@S2101-09.ap.freescale.net>
References: <CAOh2x=n11TXfKp3HkEPFTeFi2qO7tKmedSL7zPeU842-+tu47w@mail.gmail.com>
 <20120501114743.GD2194@S2101-09.ap.freescale.net>
Message-ID: <201205011239.36378.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 May 2012, Shawn Guo wrote:
> > ----------------------------------------------------------------
> > Sascha Hauer (1):
> >       clk: add a fixed factor clock
> > 
> I think it makes more sense to have this patch picked up by Mike, so
> that other platform porting do not have to depend on spear-clk branch.
> 

Yes, good point. Also, there is no actual dependency of this patch on
the other spear patches that came before it, so it should not be based
on those but on an -rc tag or on other clock patches.

	Arnd
