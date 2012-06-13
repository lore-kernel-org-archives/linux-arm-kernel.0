From: tony@atomide.com (Tony Lindgren)
Date: Wed, 13 Jun 2012 04:32:17 -0700
Subject: [PATCH 3/3] ARM: OMAP2+: gpmc: handle additional timings
In-Reply-To: <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
References: <cover.1339419244.git.afzal@ti.com>
 <c4bd7d71e9950c09f9712077160b6231f566d8f3.1339419244.git.afzal@ti.com>
 <4FD63DBF.9000200@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E997D9E@DBDE01.ent.ti.com>
 <4FD77E35.3050703@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E998767@DBDE01.ent.ti.com>
Message-ID: <20120613113217.GK12766@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Mohammed, Afzal <afzal@ti.com> [120612 22:00]:
> Hi Jon,
> 
> On Tue, Jun 12, 2012 at 23:06:53, Hunter, Jon wrote:
> 
> > Should you at least warn, if you are going to over-write a value?
> 
> Yes, that would be better except for too much logging, if Tony
> prefers that way I will add. 

If there's a chance it causing file system corruption, we should
test it carefully on the boards before applying. If that's done,
then there's probably no need for warnings. It's safer to disable
NAND for untested boards if there's a chance of breaking the timings.

Tony
