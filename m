From: tj@kernel.org (Tejun Heo)
Date: Fri, 14 Mar 2014 14:30:57 -0400
Subject: [PATCH] ata: ahci_platform: fix devm_ioremap_resource() return
 value checking
In-Reply-To: <2139783.QvectlX5nq@amdc1032>
References: <2139783.QvectlX5nq@amdc1032>
Message-ID: <20140314183057.GA6889@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 06:22:09PM +0100, Bartlomiej Zolnierkiewicz wrote:
> devm_ioremap_resource() returns a pointer to the remapped memory or
> an ERR_PTR() encoded error code on failure.  Fix the check inside
> ahci_platform_get_resources() accordingly.
> 
> Also while at it remove a needless line break.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
