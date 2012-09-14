From: vinod.koul@linux.intel.com (Vinod Koul)
Date: Fri, 14 Sep 2012 08:48:20 +0530
Subject: [PATCH 03/16] ARM: ep93xx: move platform_data definitions
In-Reply-To: <1347368390-31252-3-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-3-git-send-email-arnd@arndb.de>
Message-ID: <1347592700.1943.20.camel@vkoul-udesk3>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-09-11 at 14:59 +0200, Arnd Bergmann wrote:
> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
> 
> This moves such data out of the ep93xx include directories
> 

>  drivers/dma/ep93xx_dma.c                                         |    2 +-
Acked-by: Vinod Koul <vinod.koul@linux.intel.com>




-- 
~Vinod
