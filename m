From: metan@ucw.cz (Cyril Hrubis)
Date: Tue, 12 Apr 2011 17:52:17 +0200
Subject: zaurus: mmcblk0: error -110
In-Reply-To: <20110412152307.GD20815@atrey.karlin.mff.cuni.cz>
References: <20110412151547.GC20815@atrey.karlin.mff.cuni.cz>
	<BANLkTikNEJEwq4cfr6cmTcHqcRfyGLM6Ww@mail.gmail.com>
	<20110412152307.GD20815@atrey.karlin.mff.cuni.cz>
Message-ID: <20110412155217.GA982@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> > Which model do you have? And check the corresponding board file if
> > card detect GPIO handling is doing right.
> 
> I've got spitz (SL-3200).
> 
> So I suppose the board file is arch/arm/mach-pxa/spitz.c, I'll have a look.

Hmm, besides cleanup by Marek Vasut there were no changes in the code. And it
seems that it was just cleanup in spitz_card_pwr_ctrl().

-- 
metan
