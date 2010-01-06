From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Jan 2010 14:01:45 -0500 (EST)
Subject: Sending UTF-8 patches (was: [PATCH 2/2] Remove now-defunct ts7250
	nand driver)
In-Reply-To: <1262803010.3181.8484.camel@macbook.infradead.org>
References: <201001051459.58621.hartleys@visionengravers.com>
	<1262784693.3181.8034.camel@macbook.infradead.org>
	<20100106180705.GC11773@shareable.org>
	<1262803010.3181.8484.camel@macbook.infradead.org>
Message-ID: <alpine.LFD.2.00.1001061357280.21025@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jan 2010, David Woodhouse wrote:

> On Wed, 2010-01-06 at 18:07 +0000, Jamie Lokier wrote:
> > That's unfortunate.  An option to git-am or it's subsidiary tools to
> > convert the patch as well as the commit would be useful.  After all it
> > _is_ made clear in the MIME header how it's formatted.
> 
> ISTR there was some resistance to that suggestion when git-am was first
> fixed to handle the Content-Type of mails. The idea was that the patch
> should be considered sacrosanct and shouldn't be mangled.

Well, initially git-am was "fixed" by providing an option to allow 
normalization to UTF-8 of patch metadata.  Nowadays this option is the 
default.  So at least providing an option to convert the patch content 
as well might be perfectly sane.


Nicolas
