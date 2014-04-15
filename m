From: tj@kernel.org (Tejun Heo)
Date: Tue, 15 Apr 2014 08:49:36 -0400
Subject: [PATCH] pata_samsung_cf: fix ata_host_activate() failure handling
In-Reply-To: <6050762.sdUI3gZZlK@amdc1032>
References: <6050762.sdUI3gZZlK@amdc1032>
Message-ID: <20140415124936.GF1863@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 31, 2014 at 07:52:44PM +0200, Bartlomiej Zolnierkiewicz wrote:
> Add missing clk_disable() call to ata_host_activate() failure path.
> 
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to libata/for-3.15-fixes.

Thanks.

-- 
tejun
