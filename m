From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 22 Jun 2013 01:14:14 +0200
Subject: [PATCH] ARM: keystone: select ARM_ERRATA_798181 only for SMP
In-Reply-To: <51C4DC96.30406@ti.com>
References: <201306220104.31656.arnd@arndb.de> <51C4DC96.30406@ti.com>
Message-ID: <201306220114.14908.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 22 June 2013, Santosh Shilimkar wrote:
> On Friday 21 June 2013 07:04 PM, Arnd Bergmann wrote:
> > Selecting this symbol causes a build warning without SMP:
> > 
> > warning: (ARCH_KEYSTONE) selects ARM_ERRATA_798181 which has unmet direct dependencies (CPU_V7 && SMP)
> > 
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > 
> I need to borrow your build scripts. Thanks for
> the patch.

I'm currently just building 'make randconfig' in a loop, sending patches
out for every bug I find in the process.

> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

thanks,

	Arnd
