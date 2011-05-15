From: marek.vasut.n900@gmail.com (Marek Vasut)
Date: Sun, 15 May 2011 17:51:25 +0200
Subject: Zaurus CF tests -- ok
In-Reply-To: <20110515143141.GA7913@atrey.karlin.mff.cuni.cz>
References: <20110415211822.GB21111@atrey.karlin.mff.cuni.cz>
	<20110415213817.GC4420@atrey.karlin.mff.cuni.cz>
	<20110416074134.GA26440@ucw.cz>
	<201105151426.50230.marek.vasut@gmail.com>
	<20110515143141.GA7913@atrey.karlin.mff.cuni.cz>
Message-ID: <1305474685.17656.2.camel@konomi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Hi!
> > Backtrace from QEMU ... I think this is what Cyril observed. But heck,
> > it?  happens in QEMU too ;-)
> 
> Yes, that is pretty much it.
> 
> It happens randomly, eg. adding printk() line into kernel code
> (somewhere in mmc stack). Or sometimes crashes in the pccard
> initalization when two cards are inserted at the boot time.
>

It happens randomly in qemu too.
 
> -- 
> metan
