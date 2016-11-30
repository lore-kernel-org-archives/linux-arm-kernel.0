From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Nov 2016 22:11:04 +0100
Subject: [PATCH v2] soc: ti: qmss: fix the case when !SMP
In-Reply-To: <92af0586-7deb-9e94-a0e7-377337ebfb9e@oracle.com>
References: <20161130165351.1154-1-grygorii.strashko@ti.com>
 <d26f37e6-657f-ff42-2d9d-343fa47c2e5d@ti.com>
 <92af0586-7deb-9e94-a0e7-377337ebfb9e@oracle.com>
Message-ID: <5412220.B6fgWRlPCm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 30, 2016 9:13:44 AM CET Santosh Shilimkar wrote:
> 
> Can you apply this to your non critical fixes queue ?
> 
> On 11/30/2016 9:09 AM, Grygorii Strashko wrote:
> > + Santosh Shilimkar <santosh.shilimkar@oracle.com>
> >
> > On 11/30/2016 10:53 AM, Grygorii Strashko wrote:
> >> The irq_set_affinity_hint() will always fail when !SMP and
> >> Networking will fail on Keystone 2 devices in this case.
> >> Hence, fix by ignoring IRQ affinity settings when !SMP.
> >>
> >> Cc: Arnd Bergmann <arnd@arndb.de>
> >> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> >> ---
> Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
> 
> 

Applied, thanks!

	Arnd
