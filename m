From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 21 Jun 2013 19:07:02 -0400
Subject: [PATCH] ARM: keystone: select ARM_ERRATA_798181 only for SMP
In-Reply-To: <201306220104.31656.arnd@arndb.de>
References: <201306220104.31656.arnd@arndb.de>
Message-ID: <51C4DC96.30406@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 21 June 2013 07:04 PM, Arnd Bergmann wrote:
> Selecting this symbol causes a build warning without SMP:
> 
> warning: (ARCH_KEYSTONE) selects ARM_ERRATA_798181 which has unmet direct dependencies (CPU_V7 && SMP)
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
I need to borrow your build scripts. Thanks for
the patch.

Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
