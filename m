From: tj@kernel.org (Tejun Heo)
Date: Mon, 17 Mar 2014 14:57:55 -0400
Subject: [PATCH 0/4] ata: add remaining new-style AHCI platform drivers
In-Reply-To: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
References: <1395081118-15248-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <20140317185755.GA17373@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 07:31:54PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> This patch series adds new-style AHCI platform drivers for DaVinci DA850
> AHCI controller and ST SPEAr1340 AHCI controller.  As a preparation for
> adding these drivers it also fixes ahci_platform_data->suspend() handling
> (patch #1) and moves library AHCI platform code to its own file (patch #2).
> The new AHCI platform drivers are only compile tested (they are marked as
> experimental because of this) and I would ask somebody with the hardware
> to verify them (thanks!).

Nice cleanups.  I'll apply the patches once the drivers are verified
to work.

Thanks!

-- 
tejun
