From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 10 Oct 2013 09:11:11 -0400
Subject: [PATCH] ARM: DRA: DTS: Remove clock-frequency field for cpu timers
In-Reply-To: <1381391413-4361-1-git-send-email-r.sricharan@ti.com>
References: <1381391413-4361-1-git-send-email-r.sricharan@ti.com>
Message-ID: <5256A76F.2080503@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 10 October 2013 03:50 AM, Sricharan R wrote:
> The arm arch timers frequency are now programmed in the CNTFREQ
> per-cpu register by the timer code using the secure API [1].
> So remove the redundant entry from the dts.
> 
> [1] http://marc.info/?l=linux-omap&m=138139106312786&w=2
> 
> Cc: Benoit Cousson <bcousson@baylibre.com>
> Signed-off-by: Sricharan R <r.sricharan@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
