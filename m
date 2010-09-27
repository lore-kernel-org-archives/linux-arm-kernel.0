From: premi@ti.com (Premi, Sanjeev)
Date: Mon, 27 Sep 2010 19:28:49 +0530
Subject: [PATCH v5 5/5] omap: nand: making ecc layout as compatible with
	romcode ecc
In-Reply-To: <1285594634-19277-6-git-send-email-s-ghorai@ti.com>
References: <1285594634-19277-1-git-send-email-s-ghorai@ti.com>
	<1285594634-19277-6-git-send-email-s-ghorai@ti.com>
Message-ID: <B85A65D85D7EB246BE421B3FB0FBB5930233C3631E@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org 
> [mailto:linux-omap-owner at vger.kernel.org] On Behalf Of Sukumar Ghorai
> Sent: Monday, September 27, 2010 7:07 PM
> To: linux-omap at vger.kernel.org
> Cc: linux-mtd at lists.infradead.org; 
> linux-arm-kernel at lists.infradead.org; Ghorai, Sukumar; Vimal Singh
> Subject: [PATCH v5 5/5] omap: nand: making ecc layout as 
> compatible with romcode ecc
> 
>     This patch overrides nand ecc layout and bad block 
> descriptor (for 8-bit
>     device) to support hw ecc in romcode layout. So as to 
> have in sync with ecc
>     layout throughout; i.e. x-loader, u-boot and kernel.
> 
>     This patch also enables to use romcode ecc for spd and 
> zoom, by default.
> 
>     This enables to flash x-loader, u-boot, kernel, FS images 
> from kernel itself
>     and compatiable with other tools.
> 
The description seems to start with different whitespace indents
in this patch series.

~sanjeev

[snip]...[snip]
