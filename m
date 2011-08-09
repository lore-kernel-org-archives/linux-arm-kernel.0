From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 9 Aug 2011 16:34:18 +0100
Subject: [Ksummit-2011-discuss] experience with the new arm-soc
	workflow (Was: Re: ARM Maintainers workshop at Kernel Summit) 2011
In-Reply-To: <1312902462.18583.254.camel@gandalf.stny.rr.com>
References: <CACxGe6u3jrhnmL=QwCevm5ybgtGqdOzmGZpfve02M12e9v6pNQ@mail.gmail.com>
	<CAOesGMhgd9Grs7JErJ1pTY4fD_taX_YSpeKx_QS21dp2UN=vMQ@mail.gmail.com>
	<20110806212932.GT31521@pengutronix.de>
	<alpine.LFD.2.00.1108061742490.20358@xanadu.home>
	<CAHXqBF+BAdNo3NB9gk0o_aTHUxyQRHw_AvM5ok9zn2yk4NsRZw@mail.gmail.com>
	<20110807041124.GA6410@huya.qualcomm.com>
	<1312902462.18583.254.camel@gandalf.stny.rr.com>
Message-ID: <20110809153418.GC3429@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2011 at 11:07:42AM -0400, Steven Rostedt wrote:

> Where a clean up goes should be more about why the clean up is
> happening. If it is just a clean up for the sake of cleaning up, then a
> separate branch is suitable. But if a clean up is there to pave the way
> for new features, then that clean up should be with the features it
> allows to provide.

Though one of the frequent consequences of any widespread cleanup is
that it ends up touching lots of places and consequently colliding with
other work.
