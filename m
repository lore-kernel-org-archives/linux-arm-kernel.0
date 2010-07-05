From: tony@atomide.com (Tony Lindgren)
Date: Mon, 5 Jul 2010 11:14:55 +0300
Subject: [PATCH 05/33] Removing dead OMAP_IR
In-Reply-To: <b7209c2cb666c73a3affbb44c2637a4f2086af08.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<b7209c2cb666c73a3affbb44c2637a4f2086af08.1277911346.git.siccegge@cs.fau.de>
Message-ID: <20100705081453.GD15951@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Christoph Egger <siccegge@cs.fau.de> [100630 18:49]:
> OMAP_IR doesn't exist in Kconfig, therefore removing all references
> for it from the source code.

Thanks I've updated this for the new mux code for board-h4.c and applied it.
Updated patch below.

Regards,

Tony
