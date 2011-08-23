From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 23 Aug 2011 19:57:10 +0530
Subject: [PATCH v5 16/22] gpio/omap: remove bank->method & METHOD_* macros
In-Reply-To: <1312455893-14922-17-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-17-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E53B8BE.9030007@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> The only bank->type (method) used in the OMAP GPIO driver is MPUIO type as they
> need to be handled separately. Identify the same using a flag and remove all
> METHOD_* macros.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
Looks good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
