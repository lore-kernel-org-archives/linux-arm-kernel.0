From: tony@atomide.com (Tony Lindgren)
Date: Fri, 10 Feb 2012 11:19:26 -0800
Subject: [PATCH 2/2] ARM: OMAP4: Move the barrier memboclk_steal() as
 part of reserve callback
In-Reply-To: <1328191435-18652-3-git-send-email-santosh.shilimkar@ti.com>
References: <1328191435-18652-1-git-send-email-santosh.shilimkar@ti.com>
 <1328191435-18652-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20120210191926.GV1426@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [120202 05:33]:
> arm_memblock_steal() is not suppose to be used outside ->reserve callback.
> OMAP barrier errata code was using it outside reserve callback and hence
> it was broken.
> 
> Move the allocation as part of ->reserve callback to fix the it.

Please update this to mention again commit that changed things
around for arm_memblock_steal() so it's clear why this is needed
as a fix.

Regards,

Tony
