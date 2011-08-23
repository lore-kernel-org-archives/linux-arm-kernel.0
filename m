From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 23 Aug 2011 19:58:42 +0530
Subject: [PATCH v5 17/22] gpio/omap: fix bankwidth for OMAP7xx MPUIO
In-Reply-To: <1312455893-14922-18-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-18-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E53B91A.1070509@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> In all OMAP1 SoCs, the MPUIO bank width is 16 bits. But, in OMAP7xx,
> it is wrongly initialised to 32. Fix this.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
Looks like a proper BUG fix.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
