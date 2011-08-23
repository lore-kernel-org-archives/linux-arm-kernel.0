From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 23 Aug 2011 20:11:05 +0530
Subject: [PATCH v5 21/22] gpio/omap: skip operations in runtime callbacks
In-Reply-To: <1312455893-14922-22-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-22-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E53BC01.9060202@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> Most operations within runtime callbacks should be skipped when
> *_runtime_get_sync() and *_runtime_put_sync() are called in probe(),
> *_gpio_request() and *_gpio_free(). We just need clock enable/disable.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
OK.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
