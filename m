From: tony@atomide.com (Tony Lindgren)
Date: Mon, 24 Jan 2011 12:26:29 -0800
Subject: [PATCH] ARM: OMAP2: use early init hook
In-Reply-To: <20110124201731.GC13589@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
	<20110123174814.GI30094@n2100.arm.linux.org.uk>
	<20110124201731.GC13589@atomide.com>
Message-ID: <20110124202629.GE13589@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [110124 12:16]:
> 
> So far tested on zoom3 only, but the following gets it booting
> on top of your patch.

Looks like there are some other patches needed too.. At least
omap4 still fails with these.

Tony
