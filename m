From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 7 Mar 2016 12:34:10 -0800
Subject: [PATCH v4 1/7] mtd: spi-nor: fsl-quadspi: add big-endian support
In-Reply-To: <1453793041-35868-1-git-send-email-yao.yuan@freescale.com>
References: <1453793041-35868-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <20160307203410.GX55664@google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 03:23:55PM +0800, Yuan Yao wrote:
> Add R/W functions for big- or little-endian registers:
> The qSPI controller's endian is independent of the CPU core's endian.
> So far, the qSPI have two versions for big-endian and little-endian.
> 
> Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
> Acked-by: Han xu <han.xu@freescale.com>

Pushed patches 1, 2, 3, 5, and 7 to l2-mtd.git. Patch 4 seems unrelated,
and patch 6 should go through arm-soc.

Regards,
Brian
