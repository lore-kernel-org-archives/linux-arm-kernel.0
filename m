From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 23 Aug 2011 20:05:59 +0530
Subject: [PATCH v5 19/22] gpio/omap: optimize suspend and resume functions
In-Reply-To: <1312455893-14922-20-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-20-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E53BACF.1040408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> There is no need to operate on all the banks every time the function is called.
> Just operate on the current bank passed by the framework.
>
> Signed-off-by: Tarun Kanti DebBarma<tarun.kanti@ti.com>
> ---
Good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
