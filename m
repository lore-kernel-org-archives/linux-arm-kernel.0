From: khilman@ti.com (Kevin Hilman)
Date: Fri, 27 Apr 2012 13:44:02 -0700
Subject: [PATCH-V4 4/4] ARM: OMAP3+: am33xx: Add powerdomain & PRM support
In-Reply-To: <87bome579d.fsf@ti.com> (Kevin Hilman's message of "Thu, 26 Apr
 2012 17:49:02 -0700")
References: <1333123435-27186-1-git-send-email-hvaibhav@ti.com>
 <1333123435-27186-5-git-send-email-hvaibhav@ti.com>
 <87bome579d.fsf@ti.com>
Message-ID: <87lilg52i5.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

[...]

> I also don't like all the cpu_is* checking currently in omap_hwmod.c
> (which is here before you added this) and have an idea on how to clean
> it up, I should have a patch by tomorrow for this.  That should help
> adding am33xx support here without needing all the cpu_is* checking.

Series just posted: 

   http://marc.info/?l=linux-omap&m=133555727831379&w=2

Kevin
