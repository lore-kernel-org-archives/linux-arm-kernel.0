From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 01 May 2014 15:34:09 +0200
Subject: [PATCH 1/2] ARM: EXYNOS: Map SYSRAM through generic SRAM bindings
In-Reply-To: <5153376.z2oJ163pLF@wuerfel>
References: <1398941085-10224-1-git-send-email-sachin.kamat@linaro.org>
 <5153376.z2oJ163pLF@wuerfel>
Message-ID: <1625238.xy1WDqNhgs@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 1. Mai 2014, 15:32:14 schrieb Arnd Bergmann:
> On Thursday 01 May 2014 16:14:44 Sachin Kamat wrote:
> > Instead of hardcoding the SYSRAM details for each SoC,
> > pass this information through device tree (DT) and make
> > the code SoC agnostic. Generic SRAM bindings are used
> > for achieving this.
> > 
> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> > Cc: Heiko Stuebner <heiko@sntech.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> 
> Looks good to me. Both patches
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> Heiko, can you also have a look?

Already did :-)
