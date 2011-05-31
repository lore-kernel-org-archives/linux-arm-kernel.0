From: tony@atomide.com (Tony Lindgren)
Date: Tue, 31 May 2011 06:11:20 -0700
Subject: [PATCH] Fix: ZOOM: QUART: Request reset GPIO
In-Reply-To: <1305902134-22760-1-git-send-email-tarun.kanti@ti.com>
References: <1305902134-22760-1-git-send-email-tarun.kanti@ti.com>
Message-ID: <20110531131120.GN11352@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tarun Kanti DebBarma <tarun.kanti@ti.com> [110520 07:31]:
> From: Charulatha V <charu@ti.com>
> 
> Reset GPIO (OMAP_GPIO_152) for QUART in zoom2/zoom3 debug-board is
> not requested at all. This would lead to problems if this GPIO is
> wrongly requested. Hence request OMAP GPIO 152 for QUART RESET but
> do not apply a reset pulse as it would reset QUART and
> disturb the QUART settings.

Thanks adding to devel-board.

Tony
