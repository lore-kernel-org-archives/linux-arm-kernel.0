From: metan@ucw.cz (Cyril Hrubis)
Date: Sun, 15 May 2011 16:31:41 +0200
Subject: Zaurus CF tests -- ok
In-Reply-To: <201105151426.50230.marek.vasut@gmail.com>
References: <20110415211822.GB21111@atrey.karlin.mff.cuni.cz>
	<20110415213817.GC4420@atrey.karlin.mff.cuni.cz>
	<20110416074134.GA26440@ucw.cz>
	<201105151426.50230.marek.vasut@gmail.com>
Message-ID: <20110515143141.GA7913@atrey.karlin.mff.cuni.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!
> Backtrace from QEMU ... I think this is what Cyril observed. But heck, it 
> happens in QEMU too ;-)

Yes, that is pretty much it.

It happens randomly, eg. adding printk() line into kernel code (somewhere in
mmc stack). Or sometimes crashes in the pccard initalization when two cards are
inserted at the boot time.

-- 
metan
