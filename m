From: mturquette@ti.com (Turquette, Mike)
Date: Sun, 6 May 2012 19:20:18 -0700
Subject: [GIT PULL] clk for next
In-Reply-To: <20120504174558.GA6112@sirena.org.uk>
References: <20120504170533.GO4141@pengutronix.de>
 <20120504174558.GA6112@sirena.org.uk>
Message-ID: <CAJOA=zPbq+uBwGgE5qWumtNZFhwgHNVPXhRr6Hfwe5QMjoZVQg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 4, 2012 at 10:45 AM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, May 04, 2012 at 07:05:33PM +0200, Sascha Hauer wrote:
> I'd also like to get the wm831x driver in there, I've not been looking
> at it since it doesn't seem sensible to put the effort in until we've
> got stuff flowing into -next.

One thing to think about is the fact that CONFIG_COMMON_CLK pulls in
clkdev.  x86 doesn't have an arch/x86/include/asm/clkdev.h last time I
looked.

Regards,
Mike
