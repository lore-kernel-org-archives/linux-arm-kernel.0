From: tony@atomide.com (Tony Lindgren)
Date: Fri, 21 Feb 2014 15:17:15 -0800
Subject: [PATCH 1/1] ARM: OMAP: Kill warning in CPUIDLE code with
 !CONFIG_SMP
In-Reply-To: <1392623575-4884-1-git-send-email-mugunthanvnm@ti.com>
References: <1392623575-4884-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <20140221231714.GC5342@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mugunthan V N <mugunthanvnm@ti.com> [140216 23:56]:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> for non SMP build, NR_CPUS is 1 and hence the code complains with below
> warnings.
> 
> arch/arm/mach-omap2/cpuidle44xx.c:207:8: warning: array subscript is above array bounds [-Warray-bounds]
> arch/arm/mach-omap2/cpuidle44xx.c:212:11: warning: array subscript is above array bounds [-Warray-bounds]
> 
> Kill it by making array size fixed.
> 
> Acked-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>

Thanks applying into omap-for-v3.14/fixes.

Tony
