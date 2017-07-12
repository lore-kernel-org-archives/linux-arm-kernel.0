From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 12 Jul 2017 23:36:34 +0200
Subject: [PATCH] PM / Domains: Fix compilation error for devices that
 don't enable PM_SLEEP
In-Reply-To: <20170710211448.11046-1-fcooper@ti.com>
References: <20170710211448.11046-1-fcooper@ti.com>
Message-ID: <14308983.sqd8SeZiOC@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 10, 2017 04:14:48 PM Franklin S Cooper Jr wrote:
> Set pm_genpd_poweroff_noirq to NULL if CONFIG_PM_SLEEP isn't enabled.
> This is the same approach done for other PM_SLEEP related functions.
> 
> Without this patch building the kernel with the keystone_defconfig
> results in a compilation error.
> 
> Fixes: 10da65423fdb ("PM / Domains: Call driver's noirq callbacks")
> 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>

That should be fixed already in the Linus' tree.

Thanks,
Rafael
