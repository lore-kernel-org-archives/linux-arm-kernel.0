From: tony@atomide.com (Tony Lindgren)
Date: Thu, 3 May 2012 12:37:32 -0700
Subject: [PATCH-V5 2/3] arm:omap:am33xx: Add AM335XEVM machine support
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EA1348F@DBDE01.ent.ti.com>
References: <hvaibhav@ti.com>
 <1322808204-12878-3-git-send-email-hvaibhav@ti.com>
 <alpine.DEB.2.00.1205020317151.19695@utopia.booyaka.com>
 <79CD15C6BA57404B839C016229A409A83EA10A64@DBDE01.ent.ti.com>
 <20120503155717.GE5140@atomide.com>
 <79CD15C6BA57404B839C016229A409A83EA1348F@DBDE01.ent.ti.com>
Message-ID: <20120503193732.GG5140@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Hiremath, Vaibhav <hvaibhav@ti.com> [120503 09:45]:
> 
> What about cpu_is_omap34xx() true for am33xx? Should we follow it?

Well are there components that could be used as is with that?
If not, then it probably does not make sense.

BTW, you should post your patches on top of the clean-up patches
Santosh posted as that already leaves out some cpu_is_omapxxxx
checks. That's the "ARM: OMAP2+: Misc cleanup" thread.

Regards,

Tony
