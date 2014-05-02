From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 02 May 2014 11:31:11 +0900
Subject: [PATCH 1/2] ARM: EXYNOS: Map SYSRAM through generic SRAM bindings
In-Reply-To: <1625238.xy1WDqNhgs@diego>
References: <1398941085-10224-1-git-send-email-sachin.kamat@linaro.org>
 <5153376.z2oJ163pLF@wuerfel> <1625238.xy1WDqNhgs@diego>
Message-ID: <045901cf65ae$94f4f4b0$bedede10$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> Am Donnerstag, 1. Mai 2014, 15:32:14 schrieb Arnd Bergmann:
> > On Thursday 01 May 2014 16:14:44 Sachin Kamat wrote:
> > > Instead of hardcoding the SYSRAM details for each SoC,
> > > pass this information through device tree (DT) and make
> > > the code SoC agnostic. Generic SRAM bindings are used
> > > for achieving this.
> > >
> > > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > > Cc: Heiko Stuebner <heiko@sntech.de>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> >
> > Looks good to me. Both patches
> >
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Heiko, can you also have a look?
> 
> Already did :-)

Thanks you guys ;-)

I will take this series when I get confirmation of universal-c210's behavior
from Andrzej or Tomasz.

- Kukjin
