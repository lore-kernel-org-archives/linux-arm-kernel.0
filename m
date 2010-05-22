From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Sat, 22 May 2010 22:51:36 +1000
Subject: [PATCH 2/5] arm/orion5x: Base support for DNS-323 rev C1
In-Reply-To: <20100522110446.GB954@n2100.arm.linux.org.uk>
References: <1274525686.1931.140.camel@pasglop>
	<20100522110446.GB954@n2100.arm.linux.org.uk>
Message-ID: <1274532696.1931.146.camel@pasglop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2010-05-22 at 12:04 +0100, Russell King - ARM Linux wrote:
> On Sat, May 22, 2010 at 08:54:46PM +1000, Benjamin Herrenschmidt wrote:
> >  static void __init dns323_init(void)
> >  {
> > +        console_loglevel = 10;
> > +
> 
> Did you mean to leave this in?

Oops :-)

This isn't my neatest patch set, I must say. I spotted (too late) a
couple of typos and a crap hunk as well. Sorry about that, it's getting
hard to find time to hack at home with the kids :-)

In any case, let's see what other comments come in and if nothing else
is wrong, I'll post a cleaned up set some time next week.

Cheers,
Ben.
