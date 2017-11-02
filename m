From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 2 Nov 2017 11:12:08 -0400 (EDT)
Subject: [PATCH 3/3] ARM: early_printk: use printascii() rather than
 printch()
In-Reply-To: <20171102110925.GV9463@n2100.armlinux.org.uk>
References: <20171031171629.GI9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311346190.21665@knanqh.ubzr>
 <20171031175344.GJ9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311355000.21665@knanqh.ubzr>
 <20171031182024.GK9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1710311432120.21665@knanqh.ubzr>
 <SG2PR06MB1165AE45FB289039E55D03028A5E0@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <20171102000945.GT9463@n2100.armlinux.org.uk>
 <nycvar.YSQ.7.76.1711012249020.21665@knanqh.ubzr>
 <nycvar.YSQ.7.76.1711020011400.21665@knanqh.ubzr>
 <20171102110925.GV9463@n2100.armlinux.org.uk>
Message-ID: <nycvar.YSQ.7.76.1711021105350.21665@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2 Nov 2017, Russell King - ARM Linux wrote:

> So, in short, my tree is now closed in expectation of 4.14 on Sunday.
> 
> However, if you want me to remove "8705/1: early_printk: use printascii()
> rather than printch()" I can do that, but only if you tell me before
> 4pm UTC today.

I'd say: just leave things as they are. No point disturbing your tree 
again now. The downside is only cosmetic during the early boot when 
early_printk is enabled. That can be fixed in v4.15-rc1.

> If we get 4.14-rc8 instead, I'll re-open for a few days for this.

Sure.


Nicolas
