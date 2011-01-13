From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 13 Jan 2011 16:49:57 +0000
Subject: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP
	boot failure)
In-Reply-To: <20110113155152.GG4957@atomide.com>
References: <20110106180030.GA8249@n2100.arm.linux.org.uk>
	<20110106182023.GV7771@atomide.com>
	<20110106203238.GH1198@n2100.arm.linux.org.uk>
	<20110106204053.GA7771@atomide.com>
	<20110107161230.GR1198@n2100.arm.linux.org.uk>
	<20110110185209.GC4957@atomide.com>
	<20110111231611.GX4957@atomide.com>
	<2f1a86cfda277de8d190e5eb9b9ccd77@mail.gmail.com>
	<20110113091546.GA24429@n2100.arm.linux.org.uk>
	<20110113155152.GG4957@atomide.com>
Message-ID: <20110113164957.GA28040@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 07:51:53AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [110113 01:15]:
> > Given the very sorry state of OMAP in mainline at present, I'm surprised
> > that this kind of stuff is still going on...
> 
> At least I boot test the patches I send..

Which is why OMAP3 and OMAP4 can't be built in mainline because they
spit out lots of compile errors in the OMAP code...  As they won't
even compile they couldn't have been boot tested.
