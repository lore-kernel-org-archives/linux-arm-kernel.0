From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 24 Jan 2011 21:52:13 +0000
Subject: [PATCH] ARM: OMAP2: use early init hook
In-Reply-To: <20110124202629.GE13589@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
	<20110123174814.GI30094@n2100.arm.linux.org.uk>
	<20110124201731.GC13589@atomide.com>
	<20110124202629.GE13589@atomide.com>
Message-ID: <20110124215213.GA27044@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 24, 2011 at 12:26:29PM -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [110124 12:16]:
> > 
> > So far tested on zoom3 only, but the following gets it booting
> > on top of your patch.
> 
> Looks like there are some other patches needed too.. At least
> omap4 still fails with these.
