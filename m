From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 7 May 2012 10:24:59 +0100
Subject: [GIT PULL] clk for next
In-Reply-To: <CAJOA=zPbq+uBwGgE5qWumtNZFhwgHNVPXhRr6Hfwe5QMjoZVQg@mail.gmail.com>
References: <20120504170533.GO4141@pengutronix.de>
 <20120504174558.GA6112@sirena.org.uk>
 <CAJOA=zPbq+uBwGgE5qWumtNZFhwgHNVPXhRr6Hfwe5QMjoZVQg@mail.gmail.com>
Message-ID: <20120507092458.GC4415@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, May 06, 2012 at 07:20:18PM -0700, Turquette, Mike wrote:
> On Fri, May 4, 2012 at 10:45 AM, Mark Brown

> > On Fri, May 04, 2012 at 07:05:33PM +0200, Sascha Hauer wrote:
> > I'd also like to get the wm831x driver in there, I've not been looking
> > at it since it doesn't seem sensible to put the effort in until we've
> > got stuff flowing into -next.

> One thing to think about is the fact that CONFIG_COMMON_CLK pulls in
> clkdev.  x86 doesn't have an arch/x86/include/asm/clkdev.h last time I
> looked.

Everything seemed to manage to build happily enough when I was testing,
this is how I was build testing, though I'm not immediately sure why
looking again.  This does seem like we're stuck in the same failure that
we're in with gpiolib, and obviously the -next issues get in the way too :(
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120507/156ac6ac/attachment.sig>
