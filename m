From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 23 Aug 2011 20:12:14 +0530
Subject: [PATCH v5 22/22] gpio/omap: remove omap_gpio_save_context overhead
In-Reply-To: <1312455893-14922-23-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-23-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E53BC46.7050309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> Context is now saved dynamically in respective functions whenever and
> whichever registers are modified. This avoid overhead of saving all
> registers context in the runtime callback.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
Nice.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
santosh
