From: tony@atomide.com (Tony Lindgren)
Date: Thu, 15 Sep 2011 16:30:22 -0700
Subject: [GIT PULL] OMAP voltage layer cleanup for v3.2
In-Reply-To: <87d3f14n4k.fsf@ti.com>
References: <87d3f14n4k.fsf@ti.com>
Message-ID: <20110915233021.GE2284@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@ti.com> [110915 11:59]:
> Tony,
> 
> Please pull the OMAP voltage layer cleanup for v3.2.
> 
> This is a combination of the series A..E that have been posted, with
> a handful of updates throughout the comments and kerneldoc.
> 
> It is based on the powerdomain/clockdomain OMAP_CHIP cleanup from Paul
> (his pwrdm_clkdm_remove_omap_chip_cleanup_3.2 branch.)

Thanks, I've pulled Paul's omap_chip_remove_cleanup_3.2 into cleanup
branch and your voltage changes into voltage branch and rebuilt linux-omap
master branch. Then assuming no issues, I'll ask Arnd to pull these
on Friday.

Regards,

Tony
