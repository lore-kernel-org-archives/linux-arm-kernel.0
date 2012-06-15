From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 15 Jun 2012 10:49:36 +0000
Subject: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
In-Reply-To: <20120615104542.GR12766@atomide.com>
References: <C8443D0743D26F4388EA172BF4E2A7A93E999849@DBDE01.ent.ti.com>
 <20120614101901.GI12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99994C@DBDE01.ent.ti.com>
 <20120614115207.GL12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999AA4@DBDE01.ent.ti.com>
 <20120614122930.GM12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999C13@DBDE01.ent.ti.com>
 <20120614165337.GO12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A28B@DBDE01.ent.ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A2C4@DBDE01.ent.ti.com>
 <20120615104542.GR12766@atomide.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99A55E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony,

On Fri, Jun 15, 2012 at 16:15:43, Tony Lindgren wrote:

> something yesterday when manually patching the clk_activation, maybe
> I put the clk_activation value into async timings instead as I was
> seeing the tick value set to 0 for the sync mode.

I too thought like that initially, but when you told that putting
value of 1 tick made it work, I thought it is some different issue

Regards
Afzal
