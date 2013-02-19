From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 19 Feb 2013 18:47:56 +0530
Subject: [PATCH] ARM: OMAP3: board-generic: Add missing omap3_init_late
In-Reply-To: <1361278711-17672-1-git-send-email-rnayak@ti.com>
References: <1361278711-17672-1-git-send-email-rnayak@ti.com>
Message-ID: <51237B84.7060105@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 19 February 2013 06:28 PM, Rajendra Nayak wrote:
> The .init_late callback for OMAP3 has been missing for DT
> builds, which causes a lot of late PM initializations to
> be missed in turn.
>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
