From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 6 Jul 2010 16:02:47 +0200
Subject: Some benchmarks on ARM
In-Reply-To: <20100705132339.GY20855@pengutronix.de>
References: <20100702180257.GA8767@pengutronix.de>
	<alpine.LFD.2.00.1007030136510.32016@xanadu.home>
	<4C31D861.607@gmail.com> <20100705132339.GY20855@pengutronix.de>
Message-ID: <20100706140246.GA15402@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > I'm not sure if I'm doing this right, but it looks like the Sheevaplug
> > beats all ARM chips (except on FP) on the tests done at [1]. Looks
> > like these tests heavily depend on the clock frequency.
> 
> If anyone has an idea for better benchmarks, I'd be very interested. We
> have been searching for benchmarks which:
> 
> - can be easily cross compiled to all involved platforms
> - show the different aspects of the systems

You tested stuff like syscalls/fork latencies... but usually most of
the time is spent in kernel. What about pure userlevel computing
stuff, like mp3 encoding (lame), maybe video transcoding, maybe grep
could be benchmarked, and maybe factor is worth benchmarking
(http://pavelmachek.livejournal.com/77425.html)...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
