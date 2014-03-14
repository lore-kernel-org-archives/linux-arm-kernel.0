From: tj@kernel.org (Tejun Heo)
Date: Fri, 14 Mar 2014 14:31:13 -0400
Subject: [PATCH] ata: pata_imx: fix devm_ioremap_resource() return value
 checking
In-Reply-To: <2050303.yEm1sTq1hQ@amdc1032>
References: <2050303.yEm1sTq1hQ@amdc1032>
Message-ID: <20140314183113.GB6889@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 06:33:13PM +0100, Bartlomiej Zolnierkiewicz wrote:
> devm_ioremap_resource() returns a pointer to the remapped memory or
> an ERR_PTR() encoded error code on failure.  Fix the check inside
> pata_imx_probe() accordingly.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15.

Thanks.

-- 
tejun
