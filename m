From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 07:55:32 -0700
Subject: [PATCH v7 10/26] gpio/omap: remove hardcoded offsets in
	context save/restore
In-Reply-To: <1315918979-26173-11-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-11-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110921145532.GV2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:29]:
> It is not required to use hard-coded offsets any more in context save and
> restore functions and instead use the generic offsets which have been correctly
> initialized during device registration.
> 
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
