From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 11 Oct 2010 21:59:20 +0300
Subject: [PATCH v3] OMAP2/3: NAND: Convert write/read functions to raw
	read/write
In-Reply-To: <1286315819-5906-3-git-send-email-manjugk@ti.com>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com>
	<1286315819-5906-3-git-send-email-manjugk@ti.com>
Message-ID: <1286823560.1742.2.camel@brekeke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-10-06 at 03:26 +0530, G, Manjunath Kondaiah wrote:
> Following sparse warnings exists due to use of writel/w and readl/w functions.
> 
> This patch fixes the sparse warnings by converting readl/w functions usage into
> __raw_readl/__raw_readw functions.
> 
> drivers/mtd/nand/omap2.c:484:15: warning: symbol '__v' shadows an earlier one
> drivers/mtd/nand/omap2.c:484:15: originally declared here
> 
> drivers/mtd/onenand/omap2.c:86:9: warning: symbol '__v' shadows an earlier one
> drivers/mtd/onenand/omap2.c:86:9: originally declared here
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mtd at lists.infradead.org

I've pushed this patch to my l2-mtd-2.6.git.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
