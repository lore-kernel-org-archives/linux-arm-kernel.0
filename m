From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 23 Aug 2011 18:38:25 +0530
Subject: [PATCH v5 10/22] gpio/omap: use level/edge detect reg offsets
In-Reply-To: <1312455893-14922-11-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-11-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E53A649.6060106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> By adding level and edge detection register offsets and then initializing them
> correctly according to OMAP versions during device registrations we can now remove
> lot of revision checks in these functions.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---
Looks good.

Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
