From: x0148406@ti.com (Afzal Mohammed)
Date: Wed, 17 Oct 2012 11:12:55 +0530
Subject: [PATCH 0/4] OMAP-GPMC generic timing migration
In-Reply-To: <507D050D.2090402@ti.com>
References: <cover.1349450723.git.afzal@ti.com> <5076B166.2020006@gmail.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FBC41@DBDE01.ent.ti.com>
 <20121011144756.GB12552@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E9FCEC9@DBDE01.ent.ti.com>
 <20121015160154.GB15569@atomide.com> <507D050D.2090402@ti.com>
Message-ID: <507E455F.7060703@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Tuesday 16 October 2012 12:26 PM, Afzal Mohammed wrote:

> I certainly don't think it is easier, rather tougher, cleaner
> as well. One thing that worried me was, if we pursue the
> auxdata path (a last resort option) and later if it is
> objected, we would be back to square one.

I commented on auxdata usage without visualising in more
detail how it can be implemented, it was bad of me.

I doubt whether auxdata would help here, it seems using
compatible field alone would help in deciding relevant
custom timing routine. Whether we want this kind of
peripheral knowledge in gpmc driver instead of using
generic timing routine has to be decided though.

> Let me discuss internally and get back.

Regards
Afzal
