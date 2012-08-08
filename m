From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 8 Aug 2012 17:22:01 +0100
Subject: [PATCH 04/11] ARM: ux500: really kill snowball_of_platform_devs
In-Reply-To: <1344437248-20560-5-git-send-email-arnd@arndb.de>
References: <1344437248-20560-1-git-send-email-arnd@arndb.de>
 <1344437248-20560-5-git-send-email-arnd@arndb.de>
Message-ID: <20120808162200.GB30473@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2012 at 04:47:21PM +0200, Arnd Bergmann wrote:
> Commit fc67a597a "ARM: ux500: Remove temporary snowball_of_platform_devs
> enablement structure" removed the only user of this variable, but did
> not actually remove the array itself.
> 
> Without this patch, building u8500_defconfig results in:
> 
> arch/arm/mach-ux500/board-mop500.c:729:32: warning: 'snowball_of_platform_devs' defined but not used [-Wunused-variable]

I've already sent a patch that does this:

https://lkml.org/lkml/2012/7/31/305

Just waiting on Linus to review the set.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
