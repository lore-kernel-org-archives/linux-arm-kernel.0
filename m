From: santosh.shilimkar@ti.com (Santosh)
Date: Tue, 23 Aug 2011 18:27:12 +0530
Subject: [PATCH v5 07/22] gpio/omap: avoid cpu checks during module
	ena/disable
In-Reply-To: <1312455893-14922-8-git-send-email-tarun.kanti@ti.com>
References: <1312455893-14922-1-git-send-email-tarun.kanti@ti.com>
	<1312455893-14922-8-git-send-email-tarun.kanti@ti.com>
Message-ID: <4E53A3A8.3040506@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 04 August 2011 04:34 PM, Tarun Kanti DebBarma wrote:
> From: Charulatha V<charu@ti.com>
>
> Remove cpu-is checks while enabling/disabling OMAP GPIO module during a gpio
> request/free.
>
> Signed-off-by: Charulatha V<charu@ti.com>
> ---

Looks good.
Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
Santosh
