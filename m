From: hvaibhav@ti.com (Hiremath, Vaibhav)
Date: Fri, 27 Apr 2012 05:31:07 +0000
Subject: [PATCH-V5 3/3] ARM: OMAP: Make OMAP clocksource source
 selection using kernel param
In-Reply-To: <alpine.DEB.2.00.1204261636340.10308@utopia.booyaka.com>
References: <1335362340-14960-1-git-send-email-hvaibhav@ti.com>
 <1335362340-14960-4-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1204260904580.10308@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83E9FF819@DBDE01.ent.ti.com>
 <alpine.DEB.2.00.1204261330010.10308@utopia.booyaka.com>
 <alpine.DEB.2.00.1204261636340.10308@utopia.booyaka.com>
Message-ID: <79CD15C6BA57404B839C016229A409A83EA000B5@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 27, 2012 at 04:08:07, Paul Walmsley wrote:
> On Thu, 26 Apr 2012, Paul Walmsley wrote:
> 
> > Okay, thanks for testing.  Please do update this patch to use 
> > omap_hwmod_enable(), etc.; see for example omap_dm_timer_init_one().
> 
> And, just to be explicit, the ioremap(), clk_get(), and clk_enable() 
> should no longer be needed for OMAP2+, once you add the 
> omap_hwmod_enable().
> 

What about OMAP1 architecture? Will it work? 

Thanks,
Vaibhav
