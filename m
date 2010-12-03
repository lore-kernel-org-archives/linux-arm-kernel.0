From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 3 Dec 2010 22:02:41 +0000
Subject: [PATCH 0/22] More SMP cleanup
In-Reply-To: <1291413284.19493.15.camel@m0nster>
References: <20101203200746.GA10245@n2100.arm.linux.org.uk>
	<1291413284.19493.15.camel@m0nster>
Message-ID: <20101203220241.GE10245@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 03, 2010 at 01:54:44PM -0800, Daniel Walker wrote:
> On Fri, 2010-12-03 at 20:07 +0000, Russell King - ARM Linux wrote:
> > This patch series incorporates patches from the previously posted
> > "Clean up SMP IPI support" series of 9 patches.  Patch 5, and
> > 11 onwards are new.
> > 
> > This aims to reduce the amount of code in platform specific files
> > to the barest minimum, while maintaining the flexibility of the
> > API to allow platforms to decide which CPU numbers are populated.
> 
> Are you going to queue this for 2.6.38 or a later merge window?

The next merge window.  Many of the patches have already been in
linux-next for the odd occasion and not revealed any clashes.

Many of these patches are the result of larger patches I've posted
on these lists over the last week or so, broken up into smaller
chunks, massaged a bit more, and with other parts of the large
patches dropped.
