From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 23 Aug 2011 18:24:59 +0530
Subject: [PATCH v5 06/22] gpio/omap: make non-wakeup GPIO part of pdata
In-Reply-To: <1312455893-14922-7-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-7-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E53A323.6070401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> Non-wakeup GPIOs are available only in OMAP2. Avoid cpu_is checks by making
> non_wakeup_gpios as part of pdata.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---

Nice !!
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
