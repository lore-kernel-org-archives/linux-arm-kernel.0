From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 4 May 2015 11:25:03 +0530
Subject: [PATCH v5] dmaengine: xgene-dma: Fix sparse wannings warnings
In-Reply-To: <1429790205-13571-1-git-send-email-rsahu@apm.com>
References: <1429790205-13571-1-git-send-email-rsahu@apm.com>
Message-ID: <20150504055503.GA3521@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 23, 2015 at 05:26:45PM +0530, Rameshwar Prasad Sahu wrote:

Suject line should mention the fixes you are doing and not tool!
> v5 changes:
> 	* Re-pull v3 changes that I missed in v4
> 
> v4 changes:
> 	* Re-generate patch on top of latest for-linux git
> 
> v3 changes:
> 	* Minor changes in length setting in DMA descriptor
> 
> v2 changes:
> 	* Code cleanup
> 	* Changed way of setting DMA descriptors for big-endian
This is *not* supposed to be part of changelog!

You can add this after the S-O-B line!!
> 
> This patch fixes compilation sparse warnings like incorrect type in assignment
> (different base types), cast to restricted __le64, symbol
> '__UNIQUE_ID_author__COUNTER__' has multiple initializers etc.
> 
> This patch is based on slave-dma / for-linus branch.
> (commit: 11ebe4c067c7f95adff73594cb5c23f7a5c6d69e
> 	dmaengine: fix platform_no_drv_owner.cocci warnings
this too :(
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Rameshwar Prasad Sahu <rsahu@apm.com>

> 
>  MODULE_DESCRIPTION("APM X-Gene SoC DMA driver");
>  MODULE_AUTHOR("Rameshwar Prasad Sahu <rsahu@apm.com>");
> -MODULE_AUTHOR("Loc Ho <lho@apm.com>");
Pls drop this

-- 
~Vinod
