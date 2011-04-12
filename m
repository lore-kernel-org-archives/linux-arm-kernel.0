From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 12 Apr 2011 20:04:14 +0200
Subject: zaurus: mmcblk0: error -110
In-Reply-To: <20110412155217.GA982@atrey.karlin.mff.cuni.cz>
References: <20110412151547.GC20815@atrey.karlin.mff.cuni.cz>
	<BANLkTikNEJEwq4cfr6cmTcHqcRfyGLM6Ww@mail.gmail.com>
	<20110412152307.GD20815@atrey.karlin.mff.cuni.cz>
	<20110412155217.GA982@atrey.karlin.mff.cuni.cz>
Message-ID: <20110412180414.GA26916@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2011-04-12 17:52:17, Cyril Hrubis wrote:
> Hi!
> > > Which model do you have? And check the corresponding board file if
> > > card detect GPIO handling is doing right.
> > 
> > I've got spitz (SL-3200).
> > 
> > So I suppose the board file is arch/arm/mach-pxa/spitz.c, I'll have a look.
> 
> Hmm, besides cleanup by Marek Vasut there were no changes in the code. And it
> seems that it was just cleanup in spitz_card_pwr_ctrl().

With vanilla 2.6.38, I observe similar problem. MMC removal is not
detected; I get "error -110 whilst initalising SD card" on reinsert.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
