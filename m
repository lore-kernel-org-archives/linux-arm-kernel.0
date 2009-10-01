From: simon.kagstrom@netinsight.net (Simon Kagstrom)
Date: Thu, 1 Oct 2009 10:08:09 +0200
Subject: kirkwood openrd: random kernel crashes with git kernel
In-Reply-To: <200910011007.17429.dk-arm-linux@gmx.de>
References: <200910010904.18923.dk-arm-linux@gmx.de>
	<20091001090444.560b2e0a@marrow.netinsight.se>
	<200910011007.17429.dk-arm-linux@gmx.de>
Message-ID: <20091001100809.72ae92d3@marrow.netinsight.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 1 Oct 2009 10:07:17 +0200
Dieter Kiermaier <dk-arm-linux@gmx.de> wrote:

> > Try starting with openocd disconnected (i.e., the openocd program
> > suspended or terminated). I also get random crashes when that is on,
> > presumably caused by it stopping and resuming the kernel randomly (you
> > can see that in the openocd terminal window).
>
> It looks like this was the real reason!
> I've spent hours of sorting out what causes the crashes but now it's clear why it is almost random
> and not depending on my kernel configuration!

I guess this is something that should be asked to the openocd people. I
haven't got around to look at it more yet though. It might even be a
known issue I suppose.

Or perhaps the timing difference is triggering some real kernel bug.
Anyway, without OpenOCD, I don't see random kernel crashes anymore.

// Simon
