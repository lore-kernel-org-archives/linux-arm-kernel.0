From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 10 Aug 2011 00:57:13 +0900
Subject: [Ksummit-2011-discuss] experience with the new arm-soc workflow
	(Was: Re: ARM Maintainers workshop at Kernel Summit) 2011
In-Reply-To: <1312904500.18583.256.camel@gandalf.stny.rr.com>
References: <CACxGe6u3jrhnmL=QwCevm5ybgtGqdOzmGZpfve02M12e9v6pNQ@mail.gmail.com>
	<CAOesGMhgd9Grs7JErJ1pTY4fD_taX_YSpeKx_QS21dp2UN=vMQ@mail.gmail.com>
	<20110806212932.GT31521@pengutronix.de>
	<alpine.LFD.2.00.1108061742490.20358@xanadu.home>
	<CAHXqBF+BAdNo3NB9gk0o_aTHUxyQRHw_AvM5ok9zn2yk4NsRZw@mail.gmail.com>
	<20110807041124.GA6410@huya.qualcomm.com>
	<1312902462.18583.254.camel@gandalf.stny.rr.com>
	<20110809153418.GC3429@sirena.org.uk>
	<1312904500.18583.256.camel@gandalf.stny.rr.com>
Message-ID: <20110809155712.GK15861@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 11:41:40AM -0400, Steven Rostedt wrote:
> On Tue, 2011-08-09 at 16:34 +0100, Mark Brown wrote:

> > Though one of the frequent consequences of any widespread cleanup is
> > that it ends up touching lots of places and consequently colliding with
> > other work.

> Yeah, but Linus himself said he's good at merges. Normal cleanups should
> not be too difficult to figure out conflicts of this nature.

The problem from the submitter point of view is that it makes it much
more complicated to work out what to base your patches on when doing new
work, particularly if the cleanups are actually useful or relevant for
stuff you're doing.  It raises the overhead for upstreaming that little
bit more for limited practical gain.
