From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 1 Jan 2014 19:25:15 -0500
Subject: [ARM] Fix kernel compile error: drivers/crypto/ixp4xx_crypto.c.
In-Reply-To: <20140101124625.GF16456@n2100.arm.linux.org.uk>
References: <m3d2kduwd7.fsf@t19.piap.pl>
 <20131231134820.GS8064@book.gsilab.sittig.org>
 <52C3066E.1070909@infradead.org>
 <20140101123746.GB20094@book.gsilab.sittig.org>
 <20140101124625.GF16456@n2100.arm.linux.org.uk>
Message-ID: <20140102002515.GD19878@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 01, 2014 at 12:46:25PM +0000, Russell King - ARM Linux wrote:
> On Wed, Jan 01, 2014 at 01:37:46PM +0100, Gerhard Sittig wrote:
> > Last time I checked (few days ago, 'git grep -w Fixes:') it
> > wasn't, at least not within the kernel source tree and its
> > Documentation hierarchy.  Today's master still does not have it.
> > 
> > But a quick search in recent LAKML messages reveals that it's
> > been in use by e.g. Olof Johansson, Jason Cooper, Rusty Russell,
> > Dan Carpenter, Russell King, Mark Brown, Stephen Warren, Paul
> > Walmsley, and I'm not making this up but am just referring to
> > what repeatedly was requested in the past.  The form used there
> > was "Fixes: <hash> (<oneline>)" though.  A doc update may be due
> > to have a canonical format.
> 
> It was discussed at kernel summit, and I believe the resulting format
> was only published in one of the kernel summit mailing lists.  The
> outcome of it as I understand was that the format is:
> 
> Fixes: <hash> ("<one line summary>")

fwiw, Linus also recommended setting core.abbrev = 12.

thx,

Jason.
