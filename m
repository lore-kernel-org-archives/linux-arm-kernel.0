From: tony@atomide.com (Tony Lindgren)
Date: Mon, 6 May 2013 08:27:06 -0700
Subject: mach-omap2/timer.c: Bug introduced while merging patch - ff931c82
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EC7C45D@DBDE04.ent.ti.com>
References: <79CD15C6BA57404B839C016229A409A83EC7C45D@DBDE04.ent.ti.com>
Message-ID: <20130506152706.GD28721@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [130506 00:12]:
> Hi,
> 
> Not sure whether this got discussed and fixed already, but Google didn't give me anything :)
> 
> The below commit got merged wrongly to Mainline (Changes from timer.c got missed), and 
> due to this none of omap boards will boot.
> 
> 
> From ff931c821bab6713a52b768b0cd7ee7e90713b36 Mon Sep 17 00:00:00 2001
> From: Rajendra Nayak <rnayak@ti.com>
> Date: Thu, 21 Mar 2013 11:04:52 +0000
> Subject: ARM: OMAP: clocks: Delay clk inits atleast until slab is initialized
> 
> 
> It seems Linux-omap tree has the fix patch for this, and it should get pushed ASAP. 
> Below are links for Linus's mainline commit [1], the actual patch submitted to the list [2] and
> Commit  present in Linux-omap [3].

Can you please provide a proper patch for the regression since sounds
like you already figured out what happened?

Regards,

Tony 
 
> [1] http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/arch/arm/mach-omap2/io.c?id=ff931c821bab6713a52b768b0cd7ee7e90713b36
> [2] https://patchwork.kernel.org/patch/2300071/
> [3] http://git.kernel.org/cgit/linux/kernel/git/tmlind/linux-omap.git/commit/arch/arm/mach-omap2/timer.c?id=ff931c821bab6713a52b768b0cd7ee7e90713b36
