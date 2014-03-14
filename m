From: tj@kernel.org (Tejun Heo)
Date: Fri, 14 Mar 2014 14:27:22 -0400
Subject: [PATCH 2/2] ata: ahci_st: remove deprecated struct
 ahci_platform_data usage
In-Reply-To: <1561239.uqrRD3ZCZp@amdc1032>
References: <1561239.uqrRD3ZCZp@amdc1032>
Message-ID: <20140314182722.GA6843@mtj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 14, 2014 at 07:21:59PM +0100, Bartlomiej Zolnierkiewicz wrote:
> struct ahci_platform_data is deprecated (please see comments in
> <linux/ahci_platform.h> for details).  Convert ahci_st driver to
> use custom ->host_stop method instead.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Applied to 1-2 to libata/for-3.15.

Hmm... I'll wait for your reviews from now on.

Thanks.

-- 
tejun
