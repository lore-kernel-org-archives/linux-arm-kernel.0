From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 06 Jan 2010 13:55:07 -0500 (EST)
Subject: Sending UTF-8 patches (was: [PATCH 2/2] Remove now-defunct ts7250
	nand driver)
In-Reply-To: <20100106180705.GC11773@shareable.org>
References: <201001051459.58621.hartleys@visionengravers.com>
	<1262784693.3181.8034.camel@macbook.infradead.org>
	<20100106180705.GC11773@shareable.org>
Message-ID: <alpine.LFD.2.00.1001061342240.21025@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jan 2010, Jamie Lokier wrote:

> I guess it's time for a "send-hook" to use a different setting
> specially for Linux mailing lists.
> 
> Do you instead mean send the patch in UTF-8 embedded in a mail encoded
> as 8859-1?  That sounds quite difficult, if the patch is inline rather
> than attached.
> 
> An option to git-am to DTRT sounds infinitely better to me.  Shame
> it's not there; unfortunately it doesn't emit enough information to
> make it easy with a wrapper script.

I think your idea of enhancing git-am is really a good one, and I 
certainly encourage you to submit a patch to git.  The utility actually 
doing the work is git-mailinfo corresponding to builtin-mailinfo.c in 
the Git source tree.


Nicolas
