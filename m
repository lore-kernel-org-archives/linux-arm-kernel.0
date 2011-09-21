From: tony@atomide.com (Tony Lindgren)
Date: Wed, 21 Sep 2011 07:49:24 -0700
Subject: [PATCH v7 07/26] gpio/omap: avoid cpu checks during module
	ena/disable
In-Reply-To: <1315918979-26173-8-git-send-email-tarun.kanti@ti.com>
References: <1315918979-26173-1-git-send-email-tarun.kanti@ti.com>
	<1315918979-26173-8-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110921144924.GS2937@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110913 05:30]:
> From: Charulatha V <charu@ti.com>
> 
> Remove cpu-is checks while enabling/disabling OMAP GPIO module during a gpio
> request/free.
> 
> Signed-off-by: Charulatha V <charu@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Acked-by: Tony Lindgren <tony@atomide.com>
