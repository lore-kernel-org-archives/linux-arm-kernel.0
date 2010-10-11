From: dedekind1@gmail.com (Artem Bityutskiy)
Date: Mon, 11 Oct 2010 21:58:14 +0300
Subject: [PATCH v3] OMAP: NAND: Fix static declaration warning
In-Reply-To: <1286315819-5906-1-git-send-email-manjugk@ti.com>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com>
Message-ID: <1286823495.1742.0.camel@brekeke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-10-06 at 03:26 +0530, G, Manjunath Kondaiah wrote:
> This patch fixes sparse warning for static declaration of variable "use_dma"
> 
> drivers/mtd/nand/omap2.c:114:11: warning: symbol 'use_dma' was not declared. Should it be static?
> 
> Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-mtd at lists.infradead.org
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Nishanth Menon <nm@ti.com>

I've pushed this patch to my l2-mtd-2.6.git.

-- 
Best Regards,
Artem Bityutskiy (???????? ?????)
