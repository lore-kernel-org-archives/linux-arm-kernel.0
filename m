From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 29 Feb 2016 11:35:56 +0530
Subject: [PATCH] asm-generic: remove old nonatomic-io wrapper files
In-Reply-To: <1456496980-1852604-1-git-send-email-arnd@arndb.de>
References: <1456496980-1852604-1-git-send-email-arnd@arndb.de>
Message-ID: <20160229060556.GF11154@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 26, 2016 at 03:29:05PM +0100, Arnd Bergmann wrote:
> The two header files got moved to include/linux, and most
> users were already converted, this changes the remaining drivers
> and removes the files.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/dma/idma64.h                                | 2 +-
For this:

Acked-by: Vinod Koul <vinod.koul@intel.com>

Thanks
-- 
~Vinod
