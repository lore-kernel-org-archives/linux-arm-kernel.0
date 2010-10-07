From: nm@ti.com (Menon, Nishanth)
Date: Thu, 7 Oct 2010 07:17:08 -0500
Subject: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
	read/write
In-Reply-To: <1285063280-4057-10-git-send-email-manjugk@ti.com>
References: <1285063280-4057-1-git-send-email-manjugk@ti.com>
	<1285063280-4057-10-git-send-email-manjugk@ti.com>
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C014F74831E@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of G, Manjunath Kondaiah
> Sent: Tuesday, September 21, 2010 5:01 AM
> To: linux-omap at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org; linux-mtd at lists.infradead.org
> Subject: [PATCH v2 09/10] OMAP2/3: Convert write/read functions to raw
> read/write
> 
> Following sparse warnings exists due to use of writel/w and readl/w
> functions.
> 
> This patch fixes the sparse warnings by converting readl/w functions usage
> into
> __raw_readl/__raw_readw functions.

Apologies on bringing up an old topic here -> Is'nt it better to fix readl/w or writel/w than replacing it with __raw_readl/w etc?



Regards,
Nishanth Menon

[...]
