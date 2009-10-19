From: tony@atomide.com (Tony Lindgren)
Date: Sun, 18 Oct 2009 17:19:12 -0700
Subject: [PATCH 05/14] omap: Use ioremap in gpio.c
In-Reply-To: <20091017161347.GJ12576@atomide.com>
References: <20091016233624.2463.26653.stgit@localhost>
	<20091016234104.2463.54276.stgit@localhost>
	<20091017081004.GA648@n2100.arm.linux.org.uk>
	<20091017161347.GJ12576@atomide.com>
Message-ID: <20091019001911.GL12576@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [091017 09:14]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [091017 01:10]:
> > On Fri, Oct 16, 2009 at 04:41:04PM -0700, Tony Lindgren wrote:
> > > +	{ OMAP1_MPUIO_VBASE, 0, INT_MPUIO, IH_MPUIO_BASE,
> > 
> > That 0 should be NULL - it's a pointer.
> 
> Right, thanks, will update.

Here's this one updated.

Tony
