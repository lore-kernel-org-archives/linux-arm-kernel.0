From: tony@atomide.com (Tony Lindgren)
Date: Thu, 14 Jun 2012 05:30:16 -0700
Subject: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E999B34@DBDE01.ent.ti.com>
References: <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com>
 <20120613115445.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
 <20120614101901.GI12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
 <20120614114905.GK12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999B05@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999B34@DBDE01.ent.ti.com>
Message-ID: <20120614123016.GN12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [120614 05:25]:
> Hi Tony,
> 
> On Thu, Jun 14, 2012 at 17:39:41, Mohammed, Afzal wrote:
> > On Thu, Jun 14, 2012 at 17:19:06, Tony Lindgren wrote:
> 
> > > For onenand I'm getting the following error:
> > > 
> > > omap2-onenand omap2-onenand: Cannot request GPMC CS 
> > 
> > I am a bit confused with this message, for onenand, we only have,
> > 
> > pr_err("%s: Cannot request GPMC CS\n", __func__);
> > 
> > dev_err is used only for nand
> 
> This error can happen if my patches are not present,
> 
> dev_err for onenand driver was removed by,
> 
> [mtd: onenand: omap2: obtain memory from resource],
> 
> seems, mtd patches are not in your present branch

OK, I'll try with those.

Tony
