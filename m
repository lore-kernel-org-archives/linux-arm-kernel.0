From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Jul 2010 14:11:17 +0100
Subject: [PATCH] Versatile Express: add support for local timers on	CA9X4
	daughterboard
In-Reply-To: <20100709124335.GG22845@n2100.arm.linux.org.uk>
References: <1275904430-15995-1-git-send-email-will.deacon@arm.com>
	<20100709101657.GB22845@n2100.arm.linux.org.uk>
	<005201cb1f61$7162f2f0$5428d8d0$@deacon@arm.com>
	<20100709124335.GG22845@n2100.arm.linux.org.uk>
Message-ID: <005301cb1f68$378257e0$a68707a0$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Jul 09, 2010 at 01:22:48PM +0100, Will Deacon wrote:
> > That's a lot tidier, how about something like this?:
> 
> Yea.

Great - submitted as 6218/1 superseding the old patch.
 
> > My only question is; what is the commented-out timer code for in
> > ct-ca9x4.c? It would be nice to get rid of it if it's not useful.
> 
> I tried to use the core tile timers, but I couldn't get them to work
> properly (I don't remember why.)  I guess it would be preferable to
> use the core tile timers as they probably have a faster latency than
> the baseboard ones.  Hence I left the code there for when I can
> investigate a little more.

Ah, ok, I'll leave that alone then.

Thanks,

Will
