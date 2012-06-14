From: afzal@ti.com (Mohammed, Afzal)
Date: Thu, 14 Jun 2012 11:56:06 +0000
Subject: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
In-Reply-To: <20120614115207.GL12766@atomide.com>
References: <4FD63DBF.9000200@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
 <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
 <20120613113217.GK12766@atomide.com> <20120613115445.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998C80@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
 <20120614101901.GI12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
 <20120614115207.GL12766@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E999AA4@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Thu, Jun 14, 2012 at 17:22:08, Tony Lindgren wrote:
> * Mohammed, Afzal <afzal@ti.com> [120614 03:43]:
> > +       t.clk_activation = fclk_offset_ns;
> > +
> 
> This too should be fclk_offset, not fclk_offset_ns.

As gpmc_cs_set_timing convert it to ticks from ns,
shouldn't we put it in ns ? 

Regards
Afzal
