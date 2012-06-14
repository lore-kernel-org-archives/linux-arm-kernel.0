From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 14 Jun 2012 08:44:01 +0000
Subject: [PATCH v5 05/14] ARM: OMAP2+: gpmc: resource creation helpers
In-Reply-To: <4FD8B2D8.9000603@ti.com>
References: <cover.1339419492.git.afzal@ti.com>
 <3b124fd254f5700187a2ec5a423271a7296e0510.1339419492.git.afzal@ti.com>
 <4FD65BA5.4020205@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997EE1@DBDE01.ent.ti.com>
 <4FD7841D.1000202@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9987E3@DBDE01.ent.ti.com>
 <4FD8B2D8.9000603@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E9996BE@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jon,

On Wed, Jun 13, 2012 at 21:03:44, Hunter, Jon wrote:
> On 06/13/2012 12:29 AM, Mohammed, Afzal wrote:

> > Irq & memory resource creation functions returns number of resources,
> > if memory function only is modified, that will cause loss of uniformity
> > w.r.t irq function, even though both does similar things.
> 
> Ok, I see what you mean but from a readability standpoint it looked odd.
> The other function is returning "n" where as this is just returning 1 on
> success but it is not clear that this actually means 1 resource.

Ok, I will add comments to make it clear

Regards
Afzal
