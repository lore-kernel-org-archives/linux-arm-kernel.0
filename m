From: afzal@ti.com (Mohammed, Afzal)
Date: Wed, 13 Jun 2012 05:29:31 +0000
Subject: [PATCH v5 05/14] ARM: OMAP2+: gpmc: resource creation helpers
In-Reply-To: <4FD7841D.1000202@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <3b124fd254f5700187a2ec5a423271a7296e0510.1339419492.git.afzal@ti.com>
 <4FD65BA5.4020205@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997EE1@DBDE01.ent.ti.com>
 <4FD7841D.1000202@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9987E3@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Tue, Jun 12, 2012 at 23:32:05, Hunter, Jon wrote:

> Well looking at the function it seems that you either return an error
> code or 1. So if you are never going to return anything other than 1 on
> success it may as well be 0.

Irq & memory resource creation functions returns number of resources,
if memory function only is modified, that will cause loss of uniformity
w.r.t irq function, even though both does similar things.

Regards
Afzal
