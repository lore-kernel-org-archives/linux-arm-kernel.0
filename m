From: daniel@caiaq.de (Daniel Mack)
Date: Mon, 8 Mar 2010 11:31:08 +0100
Subject: weirdness with compiling a 2.6.33 kernel on arm debian
In-Reply-To: <20100308095337.GB27502@pengutronix.de>
References: <25ae2d691003051958x72040b47g29d842f1d389a6cf@mail.gmail.com>
	<19346.6765.457769.167118@pilspetsen.it.uu.se>
	<25ae2d691003060224x67ab1c9au5102c8a22518aff@mail.gmail.com>
	<20100306104131.GV28972@buzzloop.caiaq.de>
	<25ae2d691003061705l5fc0bca7n4a07f558a0c410cf@mail.gmail.com>
	<20100308095337.GB27502@pengutronix.de>
Message-ID: <20100308103108.GF28972@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 08, 2010 at 10:53:37AM +0100, Uwe Kleine-K?nig wrote:
> On Sun, Mar 07, 2010 at 12:05:21PM +1100, dave b wrote:
> > Ok... however how should one test the memory of an arm machine? ...
> > memtest is only for x86. *I am referring to the kernel memtest and not
> > memtest86.
> The easiest is:  rerun make and check if it fails at exactly the same
> place.

Hmm, I wonder whether this is in any way related to what Pavel and Cyril
reported in the 'bit error' thread.

Dave, does your bootloader have any memory test built-in? Do you see the
same issues with any older kernel?

FWIW, we're currently hunting a strange bug with hanging tasks, which
only seems to affect systems with Wifi enabled. That might be totally
unrelated to both of these issues though.

Daniel
