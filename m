From: tony@atomide.com (Tony Lindgren)
Date: Tue, 8 Mar 2011 15:38:21 -0800
Subject: [PATCH 2 00/18] I2C: OMAP: Fixes and removal of cpu_... from
	driver
In-Reply-To: <4D76A164.2060801@ti.com>
References: <20110308105934.23531.83540.stgit@otae.warmcat.com>
	<4D76A164.2060801@ti.com>
Message-ID: <20110308233820.GJ26463@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Cousson, Benoit <b-cousson@ti.com> [110308 13:34]:
> Hi Andy,
> 
> Thanks for that really fast update. That looks pretty good at first
> glance. I still have to review in details.

Yes nice job!
 
> And we need to find some volunteers for OMAP1 & 2 testing.

I gave it a quick try on osk5912, seems to work just fine.
Will apply these for testing purposes to linux-omap tree while
waiting for the minor fixes.

Looks like Benoit should take the arch/arm/*omap*/*hwmod*
patches, the rest should go throug Ben. So for all of them:

Acked-by: Tony Lindgren <tony@atomide.com>
