From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Mon, 12 Jul 2010 10:40:36 -0700
Subject: ARM defconfig files
In-Reply-To: <20100712173228.GC9897@n2100.arm.linux.org.uk>
References: <20100603074548.GA12104@flint.arm.linux.org.uk>
	<alpine.LFD.2.00.1006030725420.8175@i5.linux-foundation.org>
	<20100603181010.GA25779@flint.arm.linux.org.uk>
	<1275589230.23384.19.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1006031119440.8175@i5.linux-foundation.org>
	<20100614083214.GA2104@pengutronix.de>
	<20100630104043.GG11746@pengutronix.de>
	<20100712155518.GA24144@pengutronix.de>
	<AANLkTilhI9O6YwnuAylo_jNgwR8VXmpSVJ1kylIYPCGT@mail.gmail.com>
	<20100712173228.GC9897@n2100.arm.linux.org.uk>
Message-ID: <AANLkTinxUqzxClVDTyruJ6kzFTganXUGJJHJ5wRi9Iak@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 12, 2010 at 10:32 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
>
> When you brought up the problem you seemed absolutely convinced
> that nothing except your solution was going to be acceptable.

That's not true. What's true is that you didn't seem to _understand_
my solution, so I tried to push the understanding of it.

There are always other solutions. I seriously doubt that Uwe's is a
maintainable one. That said, even a one-time "reduce the size of that
stinking pile of sh*t" is probably better than nothing.

I hope you at least do agree that the current situation is a steaming
pile of sh*t. And yes, I _will_ remove the crap, both from POWER and
ARM, unless I see some serious tries at fixing it.

               Linus
