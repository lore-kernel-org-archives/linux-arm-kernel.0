From: metan@ucw.cz (Cyril Hrubis)
Date: Tue, 12 Apr 2011 17:23:07 +0200
Subject: zaurus: mmcblk0: error -110
In-Reply-To: <BANLkTikNEJEwq4cfr6cmTcHqcRfyGLM6Ww@mail.gmail.com>
References: <20110412151547.GC20815@atrey.karlin.mff.cuni.cz>
	<BANLkTikNEJEwq4cfr6cmTcHqcRfyGLM6Ww@mail.gmail.com>
Message-ID: <20110412152307.GD20815@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> Which model do you have? And check the corresponding board file if
> card detect GPIO handling is doing right.

I've got spitz (SL-3200).

So I suppose the board file is arch/arm/mach-pxa/spitz.c, I'll have a look.

-- 
metan
