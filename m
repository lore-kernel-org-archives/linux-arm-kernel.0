From: afzal@ti.com (Mohammed, Afzal)
Date: Fri, 22 Jun 2012 13:29:38 +0000
Subject: [PATCH v5 02/14] ARM: OMAP2+: gpmc: Adapt to HWMOD
In-Reply-To: <4FE25E5C.9020908@ti.com>
References: <4FD8A906.8080202@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999582@DBDE01.ent.ti.com>
 <4FD9E5AF.6010201@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E999CA6@DBDE01.ent.ti.com>
 <4FDA3464.4040704@ti.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A511@DBDE01.ent.ti.com>
 <20120615124520.GS12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99A9E7@DBDE01.ent.ti.com>
 <20120620132848.GK12766@atomide.com>
 <C8443D0743D26F4388EA172BF4E2A7A93E99D1C5@DBDE01.ent.ti.com>
 <20120620151221.GT12766@atomide.com> <4FE25E5C.9020908@ti.com>
Message-ID: <C8443D0743D26F4388EA172BF4E2A7A93E99E02E@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tony, Jon,

On Thu, Jun 21, 2012 at 05:05:56, Hunter, Jon wrote:
> On 06/20/2012 10:12 AM, Tony Lindgren wrote:
> > * Mohammed, Afzal <afzal@ti.com> [120620 07:57]:

> Therefore, I am wondering if Afzal's driver needs to register the gpmc
> devices outside of the gpmc_probe() and add the devices as children. Or
> maybe we tackle that when we migrate it to DT.

V6 of this series has been posted assuming that we tackle above issue
during DT migration

> >> For gpmc driver to calculate timings rather than platform code doing it,
> >> we first need to have a generalized way to calculate gpmc timings for
> >> all peripherals as well as have a logic to calculate timings based on
> >> time & cycles, correct ? (to make sure we are talking the same thing)
> > 
> > Yes that might be tricky..
> 
> I am wondering more and more if we need to do a clean-up of the timing
> calculations prior to driver migration ...

I propose to have clean-up of timing calculations after driver migration,
v6 of this series has been posted, except the controversial issue of clock,
I believe other issues has been addressed.

Please let me know your comments.

Regards
Afzal
