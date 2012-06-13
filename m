From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 13 Jun 2012 13:14:48 +0000
Subject: [PATCH 4/9] ARM: OMAP2+: gpmc-tusb6010: Adapt to use gpmc driver
In-Reply-To: <20120613122747.GQ12766@atomide.com>
References: <cover.1339419379.git.afzal@ti.com>
 <9c6c6b0298e37b1985a89e2cd99c35504521a1da.1339419379.git.afzal@ti.com>
 <20120613122747.GQ12766@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E998E65@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Wed, Jun 13, 2012 at 17:57:48, Tony Lindgren wrote:

> We can drop the old interface for non-mainline cases. In this case
> tusb6010 is only used by board-n8x0.c, so it's best to just convert
> it all to use the new interface.

Right, I will do accordingly

Regards
Afzal
